import Flutter
import UIKit

// Platform view factory for Revolut Pay button
class RevolutPayButtonViewFactory: NSObject, FlutterPlatformViewFactory {
    private weak var plugin: RevolutSdkBridgePlugin?
    private let callbacks: RevolutCallbackSender?

    init(plugin: RevolutSdkBridgePlugin, callbacks: RevolutCallbackSender?) {
        self.plugin = plugin
        self.callbacks = callbacks
        super.init()
    }

    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        callbacks?.log( [
            "level": "INFO",
            "message": "Creating platform view with ID: \(viewId), frame: \(frame)",
            "timestamp": nowMillis(),
            "source": "iOS_ButtonViewFactory"
        ])

        let buttonView = RevolutPayButtonView(frame: frame, viewIdentifier: viewId, arguments: args, plugin: plugin, callbacks: callbacks)

        // Store the button view instance in the main plugin for payment result handling
        if let plugin = plugin,
           let buttonId = (args as? [String: Any])?["buttonId"] as? Int {
            plugin.buttonViewInstances[buttonId] = buttonView
            callbacks?.log( [
                "level": "INFO",
                "message": "Stored button view instance for button ID: \(buttonId)",
                "timestamp": nowMillis(),
                "source": "iOS_ButtonViewFactory"
            ])
        }

        return buttonView
    }

    func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}
