package com.revolutpay.flutter.views

import android.content.Context
import android.view.View
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import com.revolut.payments.RevolutPaymentsSDK
import com.revolut.revolutpay.api.order.Customer
import com.revolut.revolutpay.api.revolutPay
import com.revolut.revolutpay.api.CountryCode
import com.revolut.revolutpay.api.promobanner.PromoBannerParams
import com.revolut.payments.RevolutCurrency
import com.revolutpay.flutter.RevolutSdkBridgePlugin
import com.revolutpay.flutter.generated.*

/** Platform view factory for the Revolut Pay promotional banner */
class RevolutPayPromoBannerViewFactory(
    private val plugin: RevolutSdkBridgePlugin
) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
        @Suppress("UNCHECKED_CAST")
        val creationParams = args as? Map<String, Any?>
        return RevolutPayPromoBannerView(context!!, creationParams, plugin)
    }
}

/**
 * Platform view that renders the native Revolut Pay promotional banner via
 * RevolutPaymentsSDK.revolutPay.providePromotionalBannerWidget(...).
 *
 * The promotional banner requires customer details (email, phone, country) — unlike the
 * pay button, it cannot be rendered without them.
 */
class RevolutPayPromoBannerView(
    private val context: Context,
    creationParams: Map<String, Any?>?,
    private val plugin: RevolutSdkBridgePlugin
) : PlatformView {

    private val bannerView: View

    init {
        bannerView = try {
            buildBanner(creationParams)
        } catch (e: Exception) {
            plugin.logToDartPublic("ERROR", "Failed to create promotional banner: ${e.message}")
            View(context)
        }
    }

    private fun buildBanner(params: Map<String, Any?>?): View {
        val promo = (params?.get("promoParams") as? Map<*, *>)?.mapKeys { it.key.toString() }
            ?: throw IllegalArgumentException("Missing promoParams")

        val transactionId = promo["transactionId"] as? String
            ?: throw IllegalArgumentException("Missing transactionId")

        val paymentAmount = when (val amount = promo["paymentAmount"]) {
            is Int -> amount.toLong()
            is Long -> amount
            is Double -> amount.toLong()
            is String -> amount.toLongOrNull() ?: 0L
            else -> 0L
        }

        val currency = (promo["currency"] as? String)?.uppercase()
            ?.let { runCatching { RevolutCurrency.valueOf(it) }.getOrNull() }
            ?: RevolutCurrency.GBP

        val customerMap = (promo["customer"] as? Map<*, *>)?.mapKeys { it.key.toString() }
            ?: throw IllegalArgumentException(
                "Promotional banner requires customer details (email, phone, country)"
            )

        val countryCode = resolveCountryCode(customerMap["country"] as? String)

        val customer = Customer(
            name = customerMap["name"] as? String,
            phone = (customerMap["phone"] as? String).orEmpty(),
            email = (customerMap["email"] as? String).orEmpty(),
            dateOfBirth = null,
            country = countryCode
        )

        val bannerParams = PromoBannerParams(
            transactionId = transactionId,
            currency = currency,
            paymentAmount = paymentAmount,
            customer = customer
        )

        // themeId is an Android style resource (R.style.*) and is optional, so we rely on the
        // SDK default theme. A Dart-side string cannot map to a resource id; if you need a
        // custom banner theme, pass a style resource here and rebuild.
        return RevolutPaymentsSDK.revolutPay.providePromotionalBannerWidget(
            context = context,
            params = bannerParams
        )
    }

    private fun resolveCountryCode(code: String?): CountryCode {
        val normalized = code?.trim()?.uppercase()
        if (normalized.isNullOrEmpty()) return CountryCode.GB
        return runCatching {
            val companion = CountryCode.Companion
            val getter = companion::class.java.getMethod("get$normalized")
            getter.invoke(companion) as CountryCode
        }.getOrDefault(CountryCode.GB)
    }

    override fun getView(): View = bannerView

    override fun dispose() {}
}
