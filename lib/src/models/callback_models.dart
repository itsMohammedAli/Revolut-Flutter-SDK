/// Log entry from the native Revolut SDK
class RevolutLogEntry {
  final RevolutLogLevel level;
  final String message;
  final DateTime timestamp;
  final String source;

  RevolutLogEntry({
    required this.level,
    required this.message,
    required this.timestamp,
    required this.source,
  });

  factory RevolutLogEntry.fromMap(Map<String, dynamic> map) {
    return RevolutLogEntry(
      level: _parseLogLevel(map['level'] as String?),
      message: map['message'] as String? ?? '',
      timestamp: DateTime.fromMillisecondsSinceEpoch(
        ((map['timestamp'] as num?) ?? 0).toInt(),
      ),
      source: map['source'] as String? ?? 'Unknown',
    );
  }

  @override
  String toString() {
    return '[${timestamp.toIso8601String()}] [$source] [${level.name.toUpperCase()}] $message';
  }

  static RevolutLogLevel _parseLogLevel(String? level) {
    switch (level?.toLowerCase()) {
      case 'success':
        return RevolutLogLevel.success;
      case 'warning':
        return RevolutLogLevel.warning;
      case 'error':
        return RevolutLogLevel.error;
      case 'info':
      default:
        return RevolutLogLevel.info;
    }
  }
}

/// Log levels for Revolut SDK operations
enum RevolutLogLevel { info, success, warning, error }

/// Payment result from the native Revolut SDK
class RevolutPaymentResult {
  final bool success;
  final String message;
  final String error;
  final DateTime timestamp;

  RevolutPaymentResult({
    required this.success,
    required this.message,
    required this.error,
    required this.timestamp,
  });

  factory RevolutPaymentResult.fromMap(Map<String, dynamic> map) {
    return RevolutPaymentResult(
      success: map['success'] as bool? ?? false,
      message: map['message'] as String? ?? '',
      error: map['error'] as String? ?? '',
      timestamp: DateTime.fromMillisecondsSinceEpoch(
        ((map['timestamp'] as num?) ?? 0).toInt(),
      ),
    );
  }

  @override
  String toString() {
    if (success) {
      return '[${timestamp.toIso8601String()}] SUCCESS: $message';
    } else {
      return '[${timestamp.toIso8601String()}] ERROR: $error';
    }
  }
}
