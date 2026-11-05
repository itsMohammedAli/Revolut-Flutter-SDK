import Foundation

func maskKey(_ value: String?) -> String {
    guard let value = value, !value.isEmpty else { return "UNSET" }
    guard value.count > 8 else { return "****" }
    return "\(value.prefix(6))...(len=\(value.count))"
}

func nowMillis() -> Int {
    return Int(Date().timeIntervalSince1970 * 1000)
}
