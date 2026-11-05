import Flutter
import UIKit
import RevolutPayments
#if SWIFT_PACKAGE
import RevolutPay
#endif

// Platform view for Revolut Pay button
class RevolutPayButtonView: NSObject, FlutterPlatformView {
    private let revolutButton: UIView
    private let callbacks: RevolutCallbackSender?
    private let paymentButtonId: Int64
    private let viewId: Int64

    init(frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?, plugin: RevolutSdkBridgePlugin?, callbacks: RevolutCallbackSender?) {
        self.callbacks = callbacks
        self.viewId = viewId

        let buttonId = (args as? [String: Any])?["buttonId"] as? Int

        self.paymentButtonId = Int64(buttonId ?? Int(viewId))

        callbacks?.log( [
            "level": "INFO",
            "message": "Platform view created with Flutter ID: \(viewId), looking for button ID: \(buttonId ?? -1)",
            "timestamp": nowMillis(),
            "source": "iOS_ButtonView"
        ])

        if let plugin = plugin,
           let buttonViews = plugin.getButtonViews(),
           let buttonId = buttonId,
           let button = buttonViews[buttonId] {
            revolutButton = button
            callbacks?.log( [
                "level": "SUCCESS",
                "message": "Found actual Revolut Pay button with ID: \(buttonId)",
                "timestamp": nowMillis(),
                "source": "iOS_ButtonView"
            ])
        } else {
            // Fallback to placeholder button if actual button not found
            callbacks?.log( [
                "level": "WARNING",
                "message": "Using placeholder button - button ID \(buttonId ?? -1) not found in buttonViews",
                "timestamp": nowMillis(),
                "source": "iOS_ButtonView"
            ])

            // Create a placeholder button with Flutter styling
            let placeholderButton = UIButton(type: .system)
            placeholderButton.setTitle("Revolut Pay", for: .normal)
            placeholderButton.backgroundColor = UIColor.systemBlue
            placeholderButton.setTitleColor(UIColor.white, for: .normal)
            placeholderButton.layer.cornerRadius = 8
            placeholderButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)

            // Apply Flutter style if provided
            if let styleData = (args as? [String: Any])?["style"] as? [String: Any] {
                if let height = styleData["height"] as? Double {
                    placeholderButton.frame.size.height = height
                }
                if let backgroundColor = styleData["backgroundColor"] as? Int {
                    placeholderButton.backgroundColor = UIColor(red: CGFloat((backgroundColor >> 16) & 0xFF) / 255.0,
                                                            green: CGFloat((backgroundColor >> 8) & 0xFF) / 255.0,
                                                            blue: CGFloat(backgroundColor & 0xFF) / 255.0,
                                                            alpha: 1.0)
                }
                if let borderRadius = styleData["borderRadius"] as? String {
                    // Parse borderRadius string and apply
                    placeholderButton.layer.cornerRadius = 12 // Default to 12 for now
                }
            }

            revolutButton = placeholderButton
        }

        callbacks?.log( [
            "level": "INFO",
            "message": "Revolut Pay button view created with ID: \(viewId)",
            "timestamp": nowMillis(),
            "source": "iOS_ButtonView"
        ])

        super.init()
    }

    func view() -> UIView {
        return revolutButton
    }

    /// Send payment result to Flutter via the payment channel
    func sendPaymentResult(_ result: RevolutPayKit.PaymentResult) {
        let resultData: [String: Any]

        switch result {
        case .success:
            resultData = [
                "success": true,
                "message": "Payment completed successfully",
                "error": "",
                "timestamp": nowMillis()
            ]
        case .failure(let error):
            resultData = [
                "success": false,
                "message": "Payment failed",
                "error": error.localizedDescription,
                "timestamp": nowMillis()
            ]
        case .userAbandonedPayment:
            resultData = [
                "success": false,
                "message": "Payment abandoned by user",
                "error": "User cancelled the payment",
                "timestamp": nowMillis()
            ]
        @unknown default:
            resultData = [
                "success": false,
                "message": "Unknown payment result",
                "error": "Unexpected payment result: \(result)",
                "timestamp": nowMillis()
            ]
        }

        // Send to Flutter via payment channel
        callbacks?.payment(resultData, viewId: paymentButtonId)

        // Also log for debugging
        callbacks?.log( [
            "level": "INFO",
            "message": "Payment result sent to Flutter view \(viewId): \(resultData)",
            "timestamp": nowMillis(),
            "source": "iOS_ButtonView"
        ])
    }
}
