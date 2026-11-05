/// Log entry from the native Revolut SDK
class RevolutLogEntryIos {
  final RevolutLogLevelIos level;
  final String message;
  final DateTime timestamp;
  final String source;

  RevolutLogEntryIos({
    required this.level,
    required this.message,
    required this.timestamp,
    required this.source,
  });

  factory RevolutLogEntryIos.fromMap(Map<String, dynamic> map) {
    return RevolutLogEntryIos(
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

  static RevolutLogLevelIos _parseLogLevel(String? level) {
    switch (level?.toLowerCase()) {
      case 'success':
        return RevolutLogLevelIos.success;
      case 'warning':
        return RevolutLogLevelIos.warning;
      case 'error':
        return RevolutLogLevelIos.error;
      case 'info':
      default:
        return RevolutLogLevelIos.info;
    }
  }
}

/// Log levels for Revolut SDK operations
enum RevolutLogLevelIos { info, success, warning, error }

/// Payment result from the native Revolut SDK
class RevolutPaymentResultIos {
  final bool success;
  final String message;
  final String error;
  final DateTime timestamp;

  RevolutPaymentResultIos({
    required this.success,
    required this.message,
    required this.error,
    required this.timestamp,
  });

  factory RevolutPaymentResultIos.fromMap(Map<String, dynamic> map) {
    return RevolutPaymentResultIos(
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
