package com.revolutpay.flutter.views

import com.revolutpay.flutter.support.DebugLogger
import android.content.Context
import android.net.Uri
import android.view.View
import androidx.activity.ComponentActivity
import androidx.lifecycle.lifecycleScope
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import com.revolut.payments.RevolutPaymentsSDK
import com.revolut.revolutpay.api.PaymentResult
import com.revolut.revolutpay.api.PaymentState
import com.revolut.revolutpay.api.RevolutPaymentController
import com.revolut.revolutpay.api.button.BoxText
import com.revolut.revolutpay.api.button.BoxTextCurrency
import com.revolut.revolutpay.api.button.ButtonParams
import com.revolut.revolutpay.api.button.Radius
import com.revolut.revolutpay.api.button.Size
import com.revolut.revolutpay.api.button.Variant
import com.revolut.revolutpay.api.button.VariantModes
import com.revolut.revolutpay.api.order.OrderParams
import com.revolut.revolutpay.api.revolutPay
import kotlinx.coroutines.Job
import kotlinx.coroutines.flow.collectLatest
import kotlinx.coroutines.launch
import com.revolutpay.flutter.RevolutSdkBridgePlugin
import com.revolutpay.flutter.generated.*
import com.revolutpay.flutter.support.resolvePreferredMode

/** Platform view factory for Revolut Pay button */
class RevolutPayButtonViewFactory(
    private val plugin: RevolutSdkBridgePlugin
) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
        val creationParams = args as? Map<String, Any?>
        return RevolutPayButtonView(context!!, viewId, creationParams, plugin)
    }
}

/** Platform view for Revolut Pay button */
class RevolutPayButtonView(
    private val context: Context,
    private val viewId: Int,
    creationParams: Map<String, Any?>?,
    private val plugin: RevolutSdkBridgePlugin
) : PlatformView {

    companion object {
        private const val TAG = "RevolutPayButton"
    }

    private lateinit var buttonView: View
    private var orderToken: String? = null
    private var returnUrl: String? = null
    private var shouldRequestShipping: Boolean = false
    private var savePaymentMethodForMerchant: Boolean = false
    private var preferredMode: String? = null
    private var paymentController: RevolutPaymentController? = null
    private var revolutPayButton: com.revolut.revolutpay.api.RevolutPayButton? = null
    private var isPaymentInProgress: Boolean = false
    private var disposed = false
    private var paymentStateJob: Job? = null

    init {
        DebugLogger.i(TAG, "RevolutPayButtonView init start (viewId: $viewId)")


        val params = creationParams ?: emptyMap()
        orderToken = params["orderToken"] as? String
        returnUrl = params["returnURL"] as? String
        shouldRequestShipping = params["shouldRequestShipping"] as? Boolean ?: false
        savePaymentMethodForMerchant = params["savePaymentMethodForMerchant"] as? Boolean ?: false
        preferredMode = params["preferredMode"] as? String

        val buttonParamsMap = (params["buttonParams"] as? Map<*, *>)?.toStringAnyMap()

        plugin.logToDartPublic(
            "INFO",
            "Creating platform view with ID: $viewId, orderToken: ${plugin.maskOrderToken(orderToken)}"
        )

        buttonView = try {
            createRevolutPayButtonInView(context, buttonParamsMap)
        } catch (e: Exception) {
            plugin.logToDartPublic("ERROR", "Failed to create Revolut Pay button: ${e.message}")
            createPlaceholderButton(context)
        }

        plugin.buttonViewInstances[viewId] = this
        plugin.publishCurrentConfiguration("RevolutPayButtonView.init(viewId=$viewId)")

        initializeController()

        DebugLogger.i(TAG, "RevolutPayButtonView init complete (viewId: $viewId)")
    }

    private fun createPlaceholderButton(context: Context): View = View(context).apply {
        setBackgroundColor(android.graphics.Color.parseColor("#0075EB"))
        minimumHeight = 200
        minimumWidth = 400

        setOnClickListener {
            plugin.logToDartPublic("INFO", "Placeholder button clicked")
            handleButtonClick()
        }
    }

    private fun createRevolutPayButtonInView(
        context: Context,
        params: Map<String, Any?>?
    ): View {
        val resolvedParams = buildButtonParams(params)

        val button = RevolutPaymentsSDK.revolutPay.provideButton(
            context = context,
            params = resolvedParams
        )
        DebugLogger.d(TAG, "createRevolutPayButtonInView(viewId=$viewId): native button created")

        revolutPayButton = button
        button.setOnClickListener {
            plugin.logToDartPublic("INFO", "Native Revolut Pay button clicked")
            handleButtonClick()
        }
        return button
    }

    private fun handleButtonClick() {
        DebugLogger.i(TAG, "handleButtonClick (viewId=$viewId, orderToken=${plugin.maskOrderToken(orderToken)})")
        plugin.publishCurrentConfiguration("handleButtonClick(viewId=$viewId)")

        // Prevent multiple simultaneous payment attempts
        if (isPaymentInProgress) {
            plugin.logToDartPublic("WARNING", "Payment already in progress, ignoring duplicate click")
            return
        }

        if (disposed) return
        val rejection = plugin.paymentSession.start(this, orderToken.orEmpty())
        if (rejection != null) {
            plugin.logToDartPublic("WARNING", "Ignoring payment click: $rejection")
            return
        }
        isPaymentInProgress = true
        revolutPayButton?.showBlockingLoading(true)

        plugin.logToDartPublic("INFO", "Processing button click, order token: ${plugin.maskOrderToken(orderToken)}")

        plugin.sendEventPublic(
            "onButtonClick",
            mapOf(
                "buttonId" to viewId.toString(),
                "orderToken" to (orderToken ?: ""),
                "timestamp" to System.currentTimeMillis()
            )
        )
        startPayment()
    }

    private fun startPayment() {
        plugin.publishCurrentConfiguration("startPayment(viewId=$viewId)")

        val controller = paymentController
        val token = orderToken

        if (controller == null) {
            plugin.logToDartPublic("ERROR", "Payment controller unavailable for view $viewId")
            sendPaymentResult(false, "Payment controller unavailable", "controller_unavailable")
            return
        }

        if (token.isNullOrBlank()) {
            plugin.logToDartPublic("ERROR", "Missing order token for view $viewId")
            sendPaymentResult(false, "Order token is missing", "missing_order_token")
            return
        }

        val uriString = returnUrl ?: "revolut-sdk-bridge://revolut-pay"
        val returnUri = runCatching { Uri.parse(uriString) }.getOrNull()
        if (returnUri == null) {
            plugin.logToDartPublic("ERROR", "Invalid return URI: $uriString")
            sendPaymentResult(false, "Invalid return URI", "invalid_return_uri")
            return
        }

        DebugLogger.d(
            TAG,
            "startPayment(viewId=$viewId): token=${plugin.maskOrderToken(token)}, returnUri=$returnUri, " +
                "requestShipping=$shouldRequestShipping, savePaymentMethod=$savePaymentMethodForMerchant"
        )

        val orderParams = OrderParams(
            orderToken = token,
            returnUri = returnUri,
            requestShipping = shouldRequestShipping,
            savePaymentMethodForMerchant = savePaymentMethodForMerchant,
            customer = null,
            preferredMode = resolvePreferredMode(preferredMode)
        )

        try {
            controller.pay(orderParams)
            DebugLogger.i(TAG, "startPayment(viewId=$viewId): controller.pay() invoked, payment UI opening")
        } catch (e: Exception) {
            DebugLogger.e(TAG, "startPayment(viewId=$viewId): controller.pay() threw", e)
            sendPaymentResult(false, "Payment failed to start", e.message ?: "unknown_error")
        }
    }

    private fun sendPaymentResult(success: Boolean, message: String, error: String?) {
        val token = plugin.paymentSession.finish(this, success) ?: return
        isPaymentInProgress = false
        if (disposed) return
        val resultData = mapOf(
            "success" to success, "message" to message, "error" to (error ?: ""),
            "timestamp" to System.currentTimeMillis(), "viewId" to viewId,
            "orderToken" to token
        )

        // CRITICAL: Always hide the loading indicator when sending results
        // This prevents infinite loading states on errors
        revolutPayButton?.showBlockingLoading(false)

        plugin.sendPaymentResultToDart(NativePaymentResult(
            success, message, error ?: "", System.currentTimeMillis(), viewId.toLong(), token
        ))

        if (success) {
            plugin.sendEventPublic(
                "onOrderCompleted",
                mapOf<String, Any>(
                    "success" to true,
                    "orderId" to token,
                    "orderToken" to token,
                    "timestamp" to System.currentTimeMillis(),
                    "additionalData" to resultData
                )
            )
        } else {
            plugin.sendEventPublic(
                "onOrderFailed",
                mapOf<String, Any>(
                    "success" to false,
                    "error" to (error ?: ""),
                    "cause" to (error ?: ""),
                    "timestamp" to System.currentTimeMillis(),
                    "additionalData" to resultData
                )
            )
        }

        plugin.logToDartPublic(
            "INFO",
            "Payment result sent to Flutter (viewId=$viewId, success=$success, error=${error ?: ""})"
        )
    }

    private fun initializeController() {
        plugin.publishCurrentConfiguration("initializeController(viewId=$viewId)")

        // Prevent duplicate controller initialization
        if (paymentController != null) {
            DebugLogger.w(TAG, "initializeController(viewId=$viewId): controller already exists, skipping")
            return
        }

        val activity = plugin.getActivity()

        if (activity !is ComponentActivity) {
            DebugLogger.e(
                TAG,
                "initializeController(viewId=$viewId): host Activity is ${activity?.javaClass?.name ?: "null"}, " +
                    "not a ComponentActivity — make MainActivity extend FlutterFragmentActivity"
            )
            plugin.logToDartPublic(
                "WARNING",
                "Host activity is not a ComponentActivity; payment controller unavailable"
            )
            return
        }

        try {
            paymentController = RevolutPaymentsSDK.revolutPay.createController(activity) { result ->
                DebugLogger.i(TAG, "Payment result callback received: ${result.javaClass.simpleName}")
                handlePaymentResult(result)
            }
            DebugLogger.i(TAG, "initializeController(viewId=$viewId): payment controller created")
        } catch (e: Exception) {
            DebugLogger.e(TAG, "initializeController(viewId=$viewId): failed to create controller", e)
            return
        }

        val controller = paymentController
        val button = revolutPayButton
        if (controller == null || button == null) {
            DebugLogger.w(TAG, "initializeController(viewId=$viewId): missing controller or button, skipping state subscription")
        } else {
            paymentStateJob?.cancel()
            paymentStateJob = activity.lifecycleScope.launch {
                controller.paymentState.collectLatest { state ->
                    val isProcessingState = state is PaymentState.Processing
                    DebugLogger.d(
                        TAG,
                        "paymentState update(viewId=$viewId): ${state.javaClass.simpleName} | inProgress=$isPaymentInProgress"
                    )
                    // Idle/resume may arrive before the result callback. Only the
                    // terminal result may release the payment attempt.
                    button.showBlockingLoading(isPaymentInProgress || isProcessingState)
                }
            }
        }
    }

    private fun handlePaymentResult(result: PaymentResult) {
        DebugLogger.i(TAG, "handlePaymentResult(viewId=$viewId): ${result.javaClass.simpleName}")

        when (result) {
            PaymentResult.Success -> {
                sendPaymentResult(true, "Payment completed successfully", null)
            }
            is PaymentResult.UserAbandonedPayment -> {
                sendPaymentResult(
                    success = false,
                    message = "Payment abandoned by user",
                    error = "user_abandoned_payment"
                )
            }
            is PaymentResult.Failure -> {
                DebugLogger.e(TAG, "handlePaymentResult(viewId=$viewId): failure", result.exception)
                sendPaymentResult(
                    success = false,
                    message = "Payment failed",
                    error = result.exception.message ?: "payment_failure"
                )
            }
        }
    }

    private fun buildButtonParams(params: Map<String, Any?>?): ButtonParams {
        val radius = enumValueOrDefault(params?.get("radius") as? String, Radius.MEDIUM)
        val size = enumValueOrDefault(params?.get("size") as? String, Size.LARGE)
        val boxText = enumValueOrDefault(params?.get("boxText") as? String, BoxText.NONE)

        val variantMap = params?.get("variantModes") as? Map<*, *>
        val lightVariant = enumValueOrDefault(
            variantMap?.get("lightTheme") as? String,
            Variant.DARK
        )
        val darkVariant = enumValueOrDefault(
            variantMap?.get("darkTheme") as? String,
            Variant.LIGHT
        )

        val currency = (params?.get("boxTextCurrency") as? String)?.uppercase()
            ?.let { enumValueOrNull<BoxTextCurrency>(it) } ?: BoxTextCurrency.GBP

        return ButtonParams(
            radius = radius,
            buttonSize = size,
            variants = VariantModes(lightMode = lightVariant, darkMode = darkVariant),
            boxText = boxText,
            boxTextCurrency = currency
        )
    }

    override fun getView(): View = buttonView

    override fun dispose() {
        disposed = true
        paymentStateJob?.cancel()
        paymentStateJob = null
        isPaymentInProgress = false
        revolutPayButton?.showBlockingLoading(false)
        paymentController = null
        revolutPayButton = null
        plugin.buttonViewInstances.remove(viewId)
    }

    private fun Map<*, *>?.toStringAnyMap(): Map<String, Any?>? {
        if (this == null) return null
        return entries.mapNotNull { (key, value) ->
            key?.toString()?.let { it to value }
        }.toMap()
    }

    private inline fun <reified T : Enum<T>> enumValueOrDefault(
        value: String?,
        default: T
    ): T = enumValueOrNull<T>(value) ?: default

    private inline fun <reified T : Enum<T>> enumValueOrNull(value: String?): T? {
        if (value.isNullOrBlank()) return null
        return runCatching { enumValueOf<T>(value.uppercase()) }.getOrNull()
    }
}
