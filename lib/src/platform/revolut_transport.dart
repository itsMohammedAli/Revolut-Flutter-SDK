import 'package:flutter/foundation.dart';
import '../generated/revolut_api.g.dart';

/// One callback receiver per Flutter isolate, shared by all platform adapters.
/// Widget listeners are keyed by native button id and explicitly removed.
class RevolutTransport implements RevolutFlutterApi {
  RevolutTransport._();
  static final RevolutTransport instance = RevolutTransport._();
  final RevolutHostApi host = RevolutHostApi();
  bool _registered = false;
  final Map<int, void Function(NativePaymentResult)> _buttons = {};
  final Set<void Function(NativeEvent)> _events = {};
  final Set<void Function(NativeLogEntry)> _logs = {};
  final Set<void Function(NativePaymentResult)> _payments = {};

  void addSdkListeners({
    required void Function(NativeLogEntry) onLog,
    required void Function(NativePaymentResult) onPayment,
  }) {
    ensureRegistered();
    _logs.add(onLog);
    _payments.add(onPayment);
  }

  void removeSdkListeners({
    required void Function(NativeLogEntry) onLog,
    required void Function(NativePaymentResult) onPayment,
  }) {
    _logs.remove(onLog);
    _payments.remove(onPayment);
  }

  void ensureRegistered() {
    if (_registered) return;
    RevolutFlutterApi.setUp(this);
    _registered = true;
  }

  void addEventListener(void Function(NativeEvent) listener) {
    ensureRegistered();
    _events.add(listener);
  }

  void removeEventListener(void Function(NativeEvent) listener) =>
      _events.remove(listener);
  void addButtonListener(int id, void Function(NativePaymentResult) listener) {
    ensureRegistered();
    _buttons[id] = listener;
  }

  void removeButtonListener(int id) => _buttons.remove(id);

  @override
  Future<void> onPaymentResult(NativePaymentResult result) async {
    final id = result.viewId;
    if (id == null) {
      for (final listener in List.of(_payments)) {
        listener(result);
      }
    } else {
      _buttons[id]?.call(result);
    }
  }

  @override
  Future<void> onLog(NativeLogEntry entry) async {
    if (!kDebugMode) return;
    for (final listener in List.of(_logs)) {
      listener(entry);
    }
  }

  @override
  Future<void> onEvent(NativeEvent event) async {
    for (final listener in List.of(_events)) {
      listener(event);
    }
  }
}
