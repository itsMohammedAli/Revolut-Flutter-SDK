import 'package:flutter/foundation.dart';
import '../models/ios_callback_models.dart';
import '../platform/legacy_converters.dart';
import '../platform/revolut_transport.dart';

export '../models/ios_callback_models.dart';

/// Legacy iOS callback facade over the shared Pigeon callback receiver.
class RevolutCallbacksIos {
  static Function(RevolutLogEntryIos)? onLog;
  static Function(RevolutPaymentResultIos)? onPaymentResult;
  static void initialize() {
    final transport = RevolutTransport.instance;
    transport.ensureRegistered();
    transport.logListener = (entry) {
      final log = RevolutLogEntryIos.fromMap({
        'level': entry.level,
        'message': entry.message,
        'timestamp': entry.timestamp,
        'source': entry.source,
      });
      onLog?.call(log);
      debugPrint('Revolut SDK Log: $log');
    };
    transport.paymentListener = (result) =>
        onPaymentResult?.call(RevolutPaymentResultIos.fromMap(result.toMap()));
  }

  static void dispose() {
    RevolutTransport.instance.logListener = null;
    RevolutTransport.instance.paymentListener = null;
  }
}
