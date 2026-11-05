package com.revolutpay.flutter

import com.revolutpay.flutter.generated.FlutterError
import com.revolutpay.flutter.generated.InitializationRequest
import com.revolutpay.flutter.generated.PaymentRequest
import kotlin.test.Test
import kotlin.test.assertEquals
import kotlin.test.assertFailsWith

internal class RevolutSdkBridgePluginTest {
    @Test
    fun emptyMerchantKeyHasStructuredError() {
        val error = assertFailsWith<FlutterError> { RevolutSdkBridgePlugin().initialize(InitializationRequest("", "sandbox")) }
        assertEquals("INVALID_ARGUMENTS", error.code)
    }

    @Test
    fun payBeforeInitializationHasStructuredError() {
        val error = assertFailsWith<FlutterError> {
            RevolutSdkBridgePlugin().pay(PaymentRequest("token", false, null, null, false))
        }
        assertEquals("NOT_INITIALIZED", error.code)
    }
}
