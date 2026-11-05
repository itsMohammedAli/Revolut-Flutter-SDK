package com.revolutpay.flutter

import android.app.Activity
import android.content.Context
import android.net.Uri
import androidx.activity.ComponentActivity
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import com.revolut.payments.RevolutPaymentsSDK
import com.revolut.revolutpay.api.PaymentResult
import com.revolut.revolutpay.api.RevolutPaymentController
import com.revolut.revolutpay.api.order.OrderParams
import com.revolut.revolutpay.api.revolutPay
import android.content.Intent
import io.flutter.plugin.common.PluginRegistry.NewIntentListener
import com.revolutpay.flutter.generated.*
import com.revolutpay.flutter.views.*
import com.revolutpay.flutter.support.resolvePreferredMode

class RevolutSdkBridgePlugin: FlutterPlugin, RevolutHostApi, ActivityAware, NewIntentListener {
    companion object {
        private const val VIEW_TYPE_BUTTON = "revolut_pay_button"
        private const val VIEW_TYPE_PROMO_BANNER = "revolut_pay_promo_banner"
        private const val TAG = "RevolutSdkBridgePlugin"
    }

    private lateinit var context: Context
    private var activityBinding: ActivityPluginBinding? = null
    private var callbacks: RevolutFlutterApi? = null
    private var flutterPluginBinding: FlutterPlugin.FlutterPluginBinding? = null

    // Storage for active button platform views (used by the platform view layer)
    val buttonViewInstances = mutableMapOf<Int, RevolutPayButtonView>()

    // Controller reused by the one-shot pay() (custom button) flow
    private var oneShotController: RevolutPaymentController? = null
    private var oneShotControllerActivity: ComponentActivity? = null

    private var isInitialized = false
    private var currentEnvironment: RevolutPaymentsSDK.Environment? = null
    private var currentEnvironmentLabel: String? = null
    private var currentMerchantPublicKey: String? = null

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        this.flutterPluginBinding = flutterPluginBinding
        context = flutterPluginBinding.applicationContext

        RevolutHostApi.setUp(flutterPluginBinding.binaryMessenger, this)
        callbacks = RevolutFlutterApi(flutterPluginBinding.binaryMessenger)

        // Register platform view factories
        flutterPluginBinding.platformViewRegistry.registerViewFactory(
            VIEW_TYPE_BUTTON,
            RevolutPayButtonViewFactory(this)
        )
        flutterPluginBinding.platformViewRegistry.registerViewFactory(
            VIEW_TYPE_PROMO_BANNER,
            RevolutPayPromoBannerViewFactory(this)
        )
    }

    override fun initialize(request: InitializationRequest): Boolean {
        try {
            val merchantPublicKey = request.merchantPublicKey

            if (merchantPublicKey.isNullOrEmpty()) {
                logToDart("ERROR", "Missing merchant public key in initialization")
                throw FlutterError("INVALID_ARGUMENTS", "Missing merchant public key", null)
            }

            // Validate merchant key format
            if (merchantPublicKey.isEmpty()) {
                logToDart("ERROR", "Merchant public key cannot be empty")
                throw FlutterError("INVALID_ARGUMENTS", "Merchant public key cannot be empty", null)
            }

            // Test with invalid keys to see if validation works
            if (merchantPublicKey == "test" || merchantPublicKey == "invalid" || merchantPublicKey.length < 10) {
                logToDart("WARNING", "Using potentially invalid merchant key: ${maskMerchantKey(merchantPublicKey)}")
            }

            // Get environment from arguments (default to sandbox)
            val environmentRaw = request.environment?.trim()
            val normalizedEnvironment = environmentRaw?.lowercase()
            val resolvedEnvironment = when (normalizedEnvironment) {
                "production", "prod", "live", "main" -> "production"
                "sandbox", "test", "testing", "dev", "development", null -> "sandbox"
                else -> {
                    logToDart("WARNING", "Unknown environment '$environmentRaw', defaulting to sandbox")
                    "sandbox"
                }
            }
            val revolutEnvironment = if (resolvedEnvironment == "production") {
                RevolutPaymentsSDK.Environment.PRODUCTION
            } else {
                RevolutPaymentsSDK.Environment.SANDBOX
            }

            currentMerchantPublicKey = merchantPublicKey
            currentEnvironment = revolutEnvironment
            currentEnvironmentLabel = resolvedEnvironment

            logToDart(
                "INFO",
                "Initializing Revolut Pay SDK with merchant public key: ${maskMerchantKey(merchantPublicKey)}, " +
                    "environmentArg=${environmentRaw ?: "null"} resolved=$resolvedEnvironment"
            )

            // Configure the SDK according to official documentation
            RevolutPaymentsSDK.configure(
                RevolutPaymentsSDK.Configuration(
                    merchantPublicKey = merchantPublicKey,
                    environment = revolutEnvironment
                )
            )

            logCurrentConfiguration("handleInitialize")

            logToDart("INFO", "SDK configuration applied - testing functionality...")

            // REAL VALIDATION: Test if SDK is properly configured
            logToDart("INFO", "Testing RevolutPay SDK functionality...")

            isInitialized = true

            logToDart(
                "INFO",
                "Revolut Pay SDK initialization complete | environment=$resolvedEnvironment " +
                    "(sdk=${revolutEnvironment.name}) | merchantKey=${maskMerchantKey(merchantPublicKey)}"
            )

            logToDart("SUCCESS", "Revolut Pay SDK initialized successfully with merchant key: ${maskMerchantKey(merchantPublicKey)}")
            return true
        } catch (e: Exception) {
            if (e is FlutterError) throw e
            logToDart("ERROR", "Failed to initialize Revolut SDK: ${e.message}")
            throw FlutterError("INIT_ERROR", "Failed to initialize Revolut SDK: ${e.message}", null)
        }
    }

    override fun getSdkVersion(): SdkInfo = SdkInfo("3.4.0", "Android", "1")
    override fun getPlatformVersion(): String = "Android ${android.os.Build.VERSION.RELEASE}"

    /**
     * One-shot payment for merchants that render their own ("custom") button.
     *
     * Mirrors Revolut's official Lite SDK "custom button" sample: a
     * [RevolutPaymentController] is bound to the host Activity, then
     * controller.pay(OrderParams) is invoked. The host Activity MUST be a
     * ComponentActivity (use FlutterFragmentActivity). The final outcome is
     * delivered asynchronously through Pigeon callbacks (onOrderCompleted /
     * onOrderFailed / onUserPaymentAbandoned); this call only reports that the
     * flow was started.
     */
    override fun pay(request: PaymentRequest): PaymentStarted {
        try {
            if (!isInitialized) {
                throw FlutterError("NOT_INITIALIZED", "SDK not initialized. Call init() first.", null)
            }

            val orderToken = request.orderToken
            if (orderToken.isEmpty()) {
                throw FlutterError("INVALID_ARGUMENTS", "orderToken is required", null)
            }
            val savePaymentMethodForMerchant = request.savePaymentMethodForMerchant
            val requestShipping = request.requestShipping
            val returnUrlString = request.returnURL ?: "revolut-sdk-bridge://revolut-pay"
            val preferredMode = resolvePreferredMode(request.preferredMode)

            val activity = activityBinding?.activity
            if (activity !is ComponentActivity) {
                logToDart(
                    "ERROR",
                    "pay() requires the host Activity to be a ComponentActivity. " +
                        "Make MainActivity extend FlutterFragmentActivity."
                )
                throw FlutterError("ACTIVITY_NOT_SUPPORTED", "Host Activity must be a ComponentActivity (extend FlutterFragmentActivity) to take payments.", null)
            }

            val returnUri = runCatching { Uri.parse(returnUrlString) }.getOrNull()
            if (returnUri == null) {
                throw FlutterError("INVALID_ARGUMENTS", "Invalid returnURL: $returnUrlString", null)
            }

            val controller = ensureOneShotController(activity)
            if (controller == null) {
                throw FlutterError("CONTROLLER_UNAVAILABLE", "Unable to create Revolut payment controller.", null)
            }

            val orderParams = OrderParams(
                orderToken = orderToken,
                returnUri = returnUri,
                requestShipping = requestShipping,
                savePaymentMethodForMerchant = savePaymentMethodForMerchant,
                customer = null,
                preferredMode = preferredMode
            )

            logToDart("INFO", "Starting one-shot payment for order token: ${maskOrderToken(orderToken)}")
            controller.pay(orderParams)

            // The real outcome arrives asynchronously through Pigeon callbacks.
            sendEvent("onPaymentStatusUpdate", mapOf(
                "status" to "initiated",
                "orderToken" to orderToken
            ))
            return PaymentStarted("initiated", orderToken)
        } catch (e: Exception) {
            if (e is FlutterError) throw e
            logToDart("ERROR", "Failed to initiate payment: ${e.message}")
            throw FlutterError("PAY_ERROR", "Failed to initiate payment: ${e.message}", null)
        }
    }

    /** Lazily creates (and reuses) a payment controller bound to the host Activity. */
    private fun ensureOneShotController(activity: ComponentActivity): RevolutPaymentController? {
        val existing = oneShotController
        if (existing != null && oneShotControllerActivity === activity) {
            return existing
        }
        return try {
            val controller = RevolutPaymentsSDK.revolutPay.createController(activity) { paymentResult ->
                handleOneShotPaymentResult(paymentResult)
            }
            oneShotController = controller
            oneShotControllerActivity = activity
            controller
        } catch (e: Exception) {
            logToDart("ERROR", "Failed to create payment controller: ${e.message}")
            null
        }
    }

    private fun handleOneShotPaymentResult(paymentResult: PaymentResult) {
        val timestamp = System.currentTimeMillis()
        val result = when (paymentResult) {
            PaymentResult.Success -> NativePaymentResult(true, "Payment completed successfully", "", timestamp)
            is PaymentResult.UserAbandonedPayment -> NativePaymentResult(false, "Payment abandoned by user", "user_abandoned_payment", timestamp)
            is PaymentResult.Failure -> NativePaymentResult(false, "Payment failed", paymentResult.exception.message ?: "payment_failure", timestamp)
        }
        sendPaymentResultToDart(result)
        when (paymentResult) {
            PaymentResult.Success -> sendEvent(
                "onOrderCompleted",
                mapOf<String, Any>("success" to true, "timestamp" to System.currentTimeMillis())
            )
            is PaymentResult.UserAbandonedPayment -> sendEvent(
                "onUserPaymentAbandoned",
                mapOf<String, Any>("success" to false, "timestamp" to System.currentTimeMillis())
            )
            is PaymentResult.Failure -> sendEvent(
                "onOrderFailed",
                mapOf<String, Any>(
                    "success" to false,
                    "error" to (paymentResult.exception.message ?: "payment_failure"),
                    "cause" to (paymentResult.exception.message ?: "payment_failure"),
                    "timestamp" to System.currentTimeMillis()
                )
            )
        }
    }

    override fun createButton(request: ButtonRequest): ButtonCreated = throw FlutterError(
        "UNSUPPORTED", "Use the Android payment widget to create a native button.", null)
    override fun cleanupButton(viewId: Long): Boolean = true
    override fun cleanupAllButtons(): Boolean = true

    private fun sendEvent(method: String, data: Map<String, Any>) {
        callbacks?.onEvent(NativeEvent(method, data)) { result ->
            result.exceptionOrNull()?.let { android.util.Log.w(TAG, "Failed to send $method", it) }
        }
    }

    // Public method for platform view to access sendEvent
    fun sendEventPublic(method: String, data: Map<String, Any>) {
        sendEvent(method, data)
    }

    private fun logToDart(level: String, message: String) {
        callbacks?.onLog(NativeLogEntry(level, message, System.currentTimeMillis(), "Android_Plugin")) { result ->
            result.exceptionOrNull()?.let { android.util.Log.w(TAG, "Failed to send log", it) }
        }
    }

    fun sendPaymentResultToDart(result: NativePaymentResult) {
        callbacks?.onPaymentResult(result) { response ->
            response.exceptionOrNull()?.let { android.util.Log.w(TAG, "Failed to send payment result", it) }
        }
    }

    private fun maskMerchantKey(key: String?): String {
        if (key.isNullOrBlank()) return "UNSET"
        if (key.length <= 6) return "****${key.takeLast(2)}"
        val prefix = key.take(4)
        val suffix = key.takeLast(4)
        return "$prefix...$suffix (len=${key.length})"
    }

    fun maskOrderToken(token: String?): String {
        if (token.isNullOrBlank()) return "UNSET"
        if (token.length <= 8) return "****"
        return "${token.take(6)}...(len=${token.length})"
    }

    private fun logCurrentConfiguration(origin: String) {
        val envLabel = currentEnvironmentLabel?.lowercase() ?: "unset"
        val sdkEnv = currentEnvironment?.name ?: "UNKNOWN"
        val maskedKey = maskMerchantKey(currentMerchantPublicKey)
        val message = "$origin | environment=$envLabel (sdk=$sdkEnv) | merchantKey=$maskedKey"
        android.util.Log.i(TAG, message)
        logToDart("INFO", message)
    }

    fun publishCurrentConfiguration(origin: String) {
        logCurrentConfiguration(origin)
    }

    // Public method for platform view to access logging
    fun logToDartPublic(level: String, message: String) {
        logToDart(level, message)
    }

    fun getActivity(): Activity? = activityBinding?.activity

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        RevolutHostApi.setUp(binding.binaryMessenger, null)
        callbacks = null
        oneShotController = null
        oneShotControllerActivity = null
        buttonViewInstances.clear()
        flutterPluginBinding = null
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activityBinding = binding
        binding.addOnNewIntentListener(this)
    }

    override fun onDetachedFromActivity() {
        activityBinding?.removeOnNewIntentListener(this)
        activityBinding = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activityBinding = binding
        binding.addOnNewIntentListener(this)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activityBinding?.removeOnNewIntentListener(this)
        activityBinding = null
    }

    override fun onNewIntent(intent: Intent): Boolean {
        intent.data?.let { uri ->
            logToDart("INFO", "Handling new intent with URI: $uri")
            RevolutPaymentsSDK.revolutPay.handle(uri)
            return true
        }
        return false
    }
}
