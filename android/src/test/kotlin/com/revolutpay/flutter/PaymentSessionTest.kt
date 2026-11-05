package com.revolutpay.flutter

import com.revolutpay.flutter.support.PaymentSession
import kotlin.test.Test
import kotlin.test.assertEquals
import kotlin.test.assertNull

internal class PaymentSessionTest {
    private val session = PaymentSession()
    private val button = Any()
    private val customButton = Any()

    @Test
    fun blocksRepeatedLaunchesUntilTerminalResult() {
        assertNull(session.start(button, "order"))
        repeat(3) {
            assertEquals("PAYMENT_IN_PROGRESS", session.start(button, "order"))
            assertEquals("PAYMENT_IN_PROGRESS", session.start(customButton, "other"))
        }
        assertEquals("order", session.finish(button, true))
        assertNull(session.start(customButton, "other"))
    }

    @Test
    fun successCannotReopenEvenWithRecreatedButtonOrCustomPayment() {
        assertNull(session.start(button, "order"))
        assertEquals("order", session.finish(button, true))
        assertEquals("ORDER_ALREADY_COMPLETED", session.start(button, "order"))
        assertEquals("ORDER_ALREADY_COMPLETED", session.start(Any(), "order"))
        assertEquals("ORDER_ALREADY_COMPLETED", session.start(customButton, "order"))
        assertNull(session.start(button, "new-order"))
    }

    @Test
    fun failureOrCancellationAllowsRetryOfSameOrder() {
        repeat(3) {
            assertNull(session.start(button, "order"))
            assertEquals("order", session.finish(button, false))
        }
        assertNull(session.start(customButton, "order"))
    }

    @Test
    fun duplicateResultsCannotPublishAnotherOutcome() {
        assertNull(session.start(button, "order"))
        assertEquals("order", session.finish(button, true))
        assertNull(session.finish(button, true))
        assertNull(session.finish(button, false))
        assertEquals("ORDER_ALREADY_COMPLETED", session.start(button, "order"))
    }

    @Test
    fun resultFromAnotherControllerCannotReleaseActivePayment() {
        assertNull(session.start(button, "order"))
        assertNull(session.finish(customButton, true))
        assertEquals("PAYMENT_IN_PROGRESS", session.start(customButton, "other"))
        assertEquals("order", session.finish(button, true))
    }
}
