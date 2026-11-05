package com.revolutpay.flutter.support

/** Keeps payment ownership until the SDK delivers a terminal result. */
internal class PaymentSession {
    private data class Attempt(val owner: Any, val orderToken: String)
    private var active: Attempt? = null
    private val completedOrders = mutableSetOf<String>()

    fun start(owner: Any, orderToken: String): String? {
        if (active != null) return "PAYMENT_IN_PROGRESS"
        if (orderToken in completedOrders) return "ORDER_ALREADY_COMPLETED"
        active = Attempt(owner, orderToken)
        return null
    }

    // Taking the attempt before publishing callbacks makes duplicate results inert.
    fun finish(owner: Any, success: Boolean): String? {
        val attempt = active?.takeIf { it.owner === owner } ?: return null
        active = null
        if (success) completedOrders.add(attempt.orderToken)
        return attempt.orderToken
    }
}
