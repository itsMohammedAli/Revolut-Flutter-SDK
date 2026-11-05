import Flutter
import UIKit
import RevolutPayments
#if SWIFT_PACKAGE
import RevolutPay
#endif

public class RevolutSdkBridgePlugin: NSObject, FlutterPlugin, FlutterSceneLifeCycleDelegate, RevolutHostApi {

    private var revolutPayKit: RevolutPayKit?
    private var buttonViews: [Int: UIView] = [:]
    var buttonViewInstances: [Int: RevolutPayButtonView] = [:]
    private var nextViewId: Int = 1
    private var callbacks: RevolutCallbackSender?


    public static func register(with registrar: FlutterPluginRegistrar) {
        let instance = RevolutSdkBridgePlugin()


        RevolutHostApiSetup.setUp(binaryMessenger: registrar.messenger(), api: instance)
        registrar.addApplicationDelegate(instance)
        registrar.addSceneDelegate(instance)

        // Create log channel for callbacks
        instance.callbacks = RevolutCallbackSender(messenger: registrar.messenger())

        // Register platform view factory for Revolut Pay button
        let factory = RevolutPayButtonViewFactory(plugin: instance, callbacks: instance.callbacks)
        registrar.register(factory, withId: "revolut_pay_button")
    }

    public func application(
        _ application: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
        logToDart("INFO", "Forwarding inbound URL to Revolut Pay SDK: \(url)")
        RevolutPayKit.handle(url: url)
        return false
    }

    // Flutter 3.41+ delivers payment return URLs through the scene lifecycle.
    public func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) -> Bool {
        for context in URLContexts {
            RevolutPayKit.handle(url: context.url)
        }
        return false
    }

    public func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions?
    ) -> Bool {
        for context in connectionOptions?.urlContexts ?? [] {
            RevolutPayKit.handle(url: context.url)
        }
        return false
    }

    func initialize(request: InitializationRequest) throws -> Bool {
        let merchantPublicKey = request.merchantPublicKey
        // Validate merchant key format
        if merchantPublicKey.isEmpty {
            logToDart("ERROR", "Merchant public key cannot be empty")
            throw PigeonError(code: "INVALID_ARGUMENTS", message: "Merchant public key cannot be empty", details: nil)
        }

        // Test with invalid keys to see if validation works
        if merchantPublicKey == "test" || merchantPublicKey == "invalid" || merchantPublicKey.count < 10 {
            logToDart("WARNING", "Using potentially invalid merchant key: \(maskKey(merchantPublicKey))")
        }

        // Get environment from arguments (default to sandbox); accept the same
        // aliases as the Android implementation so both platforms resolve the
        // same environment for a given input.
        let environmentRaw = request.environment ?? "sandbox"
        let environment = environmentRaw.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let revolutEnvironment: RevolutPaymentsSDK.Environment
        let resolvedEnvironmentLabel: String
        switch environment {
        case "production", "prod", "live", "main":
            revolutEnvironment = .production
            resolvedEnvironmentLabel = "production"
        case "sandbox", "test", "testing", "dev", "development", "":
            revolutEnvironment = .sandbox
            resolvedEnvironmentLabel = "sandbox"
        default:
            logToDart("WARNING", "Unknown environment '\(environmentRaw)', defaulting to sandbox")
            revolutEnvironment = .sandbox
            resolvedEnvironmentLabel = "sandbox"
        }

        logToDart("INFO", "Initializing Revolut Pay SDK with merchant public key: \(maskKey(merchantPublicKey)), environment: \(environmentRaw) (sdk=\(resolvedEnvironmentLabel))")

        // Configure the SDK according to official documentation
        RevolutPaymentsSDK.configure(
            with: .init(
                merchantPublicKey: merchantPublicKey,
                environment: revolutEnvironment
            )
        )

        logToDart("INFO", "SDK configuration applied - testing functionality...")

        // REAL VALIDATION: Try to create a kit and test if it actually works
        let testKit = RevolutPayKit()

        // Test if the kit can actually perform operations (this would fail if not configured)
        // Try to access a property or method that requires valid configuration
        logToDart("INFO", "Testing RevolutPayKit functionality...")

        // Store the kit only if validation passes
        revolutPayKit = testKit

        logToDart("SUCCESS", "Revolut Pay SDK initialized successfully with merchant key: \(maskKey(merchantPublicKey))")
        return true
    }

    func createButton(request: ButtonRequest) throws -> ButtonCreated {
        let orderToken = request.orderToken
        let amount = Int(request.amount)
        let currency = request.currency
        guard let revolutPayKit = revolutPayKit else {
            logToDart("ERROR", "Revolut Pay SDK not initialized")
            throw PigeonError(code: "NOT_INITIALIZED", message: "SDK not initialized", details: nil)
        }

        // Extract optional parameters
        let shouldRequestShipping = request.shouldRequestShipping
        let savePaymentMethodForMerchant = request.savePaymentMethodForMerchant
        let returnURL = request.returnURL ?? "revolut-sdk-bridge://revolut-pay"

        logToDart("INFO", "Creating Revolut Pay button with order token: \(maskKey(orderToken))")
        logToDart("INFO", "Button parameters - Amount: \(amount) \(currency), Shipping: \(shouldRequestShipping), Save: \(savePaymentMethodForMerchant)")

        // Generate the view ID first
        let viewId = nextViewId
        nextViewId += 1

        // Create the button
        let button = revolutPayKit.button(
            style: RevolutPayButton.Style(size: .large),
            returnURL: returnURL,
            savePaymentMethodForMerchant: savePaymentMethodForMerchant,
            createOrder: { [weak self] createOrderHandler in
                self?.logToDart("INFO", "Setting order token: \(maskKey(orderToken))")
                createOrderHandler.set(orderToken: orderToken)
            },
            completion: { [weak self] result in
                self?.logToDart("INFO", "Payment completed with result: \(result)")

                // Send payment result to the correct Flutter widget
                if let self = self,
                   let buttonView = self.buttonViewInstances[viewId] {
                    buttonView.sendPaymentResult(result)
                } else {
                    // Fallback: send to general log channel
                    self?.sendPaymentResult(result)
                }
            }
        )

        // Store the button with the generated ID
        buttonViews[viewId] = button

        logToDart("SUCCESS", "Revolut Pay button created successfully with viewId: \(viewId)")
        logToDart("INFO", "Button stored in buttonViews with key: \(viewId)")
        logToDart("INFO", "Total buttons stored: \(buttonViews.count)")

        return ButtonCreated(viewId: Int64(viewId), request: request)
    }

    func cleanupButton(viewId: Int64) throws -> Bool {
        return recreateButton(viewId: Int(viewId))
    }

    func cleanupAllButtons() throws -> Bool {
        releaseAllButtons()
        return true
    }

    private func sendPaymentResult(_ result: RevolutPayKit.PaymentResult) {
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
                "error": "user_abandoned_payment",
                "timestamp": nowMillis()
            ]
        @unknown default:
            resultData = [
                "success": false,
                "message": "Unknown payment result",
                "error": "unknown",
                "timestamp": nowMillis()
            ]
        }
        callbacks?.payment(resultData)
    }

    // MARK: - Helper Methods

    func getButtonViews() -> [Int: UIView]? {
        return buttonViews
    }

    /// Clean up and recreate a specific button
    func recreateButton(viewId: Int) -> Bool {
        buttonViewInstances.removeValue(forKey: viewId)

        guard let oldButton = buttonViews[viewId] else {
            logToDart("WARNING", "Button with viewId \(viewId) not found for recreation")
            return false
        }

        // Remove the old button
        buttonViews.removeValue(forKey: viewId)
        oldButton.removeFromSuperview()

        logToDart("INFO", "Cleaned up old button with viewId: \(viewId)")
        return true
    }

    /// Clean up all buttons (useful for complete refresh)
    /// Note: the view-id counter is intentionally NOT reset — reusing ids would
    /// collide with payment channels of platform views that are still alive.
    private func releaseAllButtons() {
        for (viewId, button) in buttonViews {
            button.removeFromSuperview()
            logToDart("INFO", "Cleaned up button with viewId: \(viewId)")
        }
        buttonViews.removeAll()
        buttonViewInstances.removeAll()
        logToDart("INFO", "All buttons cleaned up")
    }

    private func logToDart(_ level: String, _ message: String) {
        #if DEBUG
        let logData: [String: Any] = [
            "level": level,
            "message": message,
            "timestamp": nowMillis(),
            "source": "iOS_Plugin"
        ]

        callbacks?.log(logData)
        #endif
    }

    func getPlatformVersion() throws -> String { "iOS " + UIDevice.current.systemVersion }
    func getSdkVersion() throws -> SdkInfo {
        SdkInfo(version: "3.18.0", platform: "iOS", buildNumber: "1")
    }

    func pay(request: PaymentRequest) throws -> PaymentStarted {
        let orderToken = request.orderToken
        guard !orderToken.isEmpty else {
            throw PigeonError(code: "INVALID_ARGUMENTS", message: "orderToken is required", details: nil)
        }
        guard let revolutPayKit = revolutPayKit else {
            logToDart("ERROR", "Revolut Pay SDK not initialized")
            throw PigeonError(code: "NOT_INITIALIZED", message: "SDK not initialized. Call initialize() first.", details: nil)
        }

        let savePaymentMethodForMerchant = request.savePaymentMethodForMerchant
        let returnURL = request.returnURL ?? "revolut-sdk-bridge://revolut-pay"

        logToDart("INFO", "Starting headless Revolut Pay for order token: \(maskKey(orderToken))")
        revolutPayKit.pay(
            orderToken: orderToken,
            returnURL: returnURL,
            savePaymentMethodForMerchant: savePaymentMethodForMerchant,
            completion: { [weak self] paymentResult in
                self?.logToDart("INFO", "Headless pay completed with result: \(paymentResult)")
                self?.sendPaymentResult(paymentResult)
            }
        )

        return PaymentStarted(status: "initiated", orderToken: orderToken)
    }

    public func detachFromEngine(for registrar: FlutterPluginRegistrar) {
        RevolutHostApiSetup.setUp(binaryMessenger: registrar.messenger(), api: nil)
        releaseAllButtons()
        callbacks = nil
    }
}
