package com.revolutpay.flutter.support

import com.revolut.revolutpay.api.order.PreferredMode

internal fun resolvePreferredMode(value: String?): PreferredMode = when (value?.trim()?.lowercase()) {
    "retailonly", "retail-only", "retail_only" -> PreferredMode.RETAIL_ONLY
    "business" -> PreferredMode.BUSINESS
    "businessonly", "business-only", "business_only" -> PreferredMode.BUSINESS_ONLY
    else -> PreferredMode.RETAIL
}
