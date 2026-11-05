package com.revolutpay.flutter.support

import android.util.Log
import com.revolutpay.flutter.BuildConfig

/** All plugin-owned Android console output is disabled outside debug builds. */
internal object DebugLogger {
    val enabled: Boolean get() = BuildConfig.DEBUG && BuildConfig.BUILD_TYPE == "debug"

    fun d(tag: String, message: String, error: Throwable? = null) {
        if (enabled) Log.d(tag, message, error)
    }
    fun i(tag: String, message: String, error: Throwable? = null) {
        if (enabled) Log.i(tag, message, error)
    }
    fun w(tag: String, message: String, error: Throwable? = null) {
        if (enabled) Log.w(tag, message, error)
    }
    fun e(tag: String, message: String, error: Throwable? = null) {
        if (enabled) Log.e(tag, message, error)
    }
}
