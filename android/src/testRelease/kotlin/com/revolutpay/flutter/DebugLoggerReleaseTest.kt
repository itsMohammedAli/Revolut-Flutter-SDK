package com.revolutpay.flutter

import com.revolutpay.flutter.support.DebugLogger
import kotlin.test.Test
import kotlin.test.assertFalse

internal class DebugLoggerReleaseTest {
    @Test
    fun releaseLoggingDoesNotTouchAndroidLog() {
        assertFalse(BuildConfig.DEBUG)
        assertFalse(DebugLogger.enabled)
        val error = IllegalStateException("diagnostic")
        // Android Log methods throw in local unit tests if called.
        DebugLogger.d("test", "debug", error)
        DebugLogger.i("test", "info", error)
        DebugLogger.w("test", "warning", error)
        DebugLogger.e("test", "error", error)
    }
}
