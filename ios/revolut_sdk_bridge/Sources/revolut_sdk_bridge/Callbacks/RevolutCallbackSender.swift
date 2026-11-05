import Flutter
import Foundation

/// Owns the generated native-to-Dart API for this Flutter engine.
final class RevolutCallbackSender {
    private let api: RevolutFlutterApi
    init(messenger: FlutterBinaryMessenger) { api = RevolutFlutterApi(binaryMessenger: messenger) }
    func log(_ data: [String: Any]) {
        let entry = NativeLogEntry(level: data["level"] as? String ?? "INFO",
            message: data["message"] as? String ?? "",
            timestamp: Int64(data["timestamp"] as? Int ?? nowMillis()),
            source: data["source"] as? String ?? "iOS_Plugin")
        DispatchQueue.main.async { [api] in
            api.onLog(entry: entry) { response in
                if case .failure(let error) = response { NSLog("Revolut log delivery failed: %@", String(describing: error)) }
            }
        }
    }
    func payment(_ data: [String: Any], viewId: Int64? = nil) {
        let result = NativePaymentResult(success: data["success"] as? Bool ?? false,
            message: data["message"] as? String ?? "", error: data["error"] as? String ?? "",
            timestamp: Int64(data["timestamp"] as? Int ?? nowMillis()), viewId: viewId)
        DispatchQueue.main.async { [api] in
            api.onPaymentResult(result: result) { response in
                if case .failure(let error) = response { NSLog("Revolut payment delivery failed: %@", String(describing: error)) }
            }
        }
    }
}
