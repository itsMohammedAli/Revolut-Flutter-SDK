import '../generated/revolut_api.g.dart';

/// One callback receiver per Flutter isolate, shared by all platform adapters.
/// Widget listeners are keyed by native button id and explicitly removed.
class RevolutTransport implements RevolutFlutterApi {
  RevolutTransport._();
  static final RevolutTransport instance = RevolutTransport._();
  final RevolutHostApi host = RevolutHostApi();
  bool _registered = false;
  bool initialized = false;
  bool get callbacksRegistered => _registered;
  final Map<int, void Function(NativePaymentResult)> _buttons = {};
  final Set<void Function(NativeEvent)> _events = {};
  void Function(NativeLogEntry)? logListener;
  void Function(NativePaymentResult)? paymentListener;

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
      paymentListener?.call(result);
    } else {
      _buttons[id]?.call(result);
    }
  }

  @override
  Future<void> onLog(NativeLogEntry entry) async {
    logListener?.call(entry);
  }

  @override
  Future<void> onEvent(NativeEvent event) async {
    for (final listener in List.of(_events)) {
      listener(event);
    }
  }
}
