import '../generated/revolut_api.g.dart';
import 'revolut_transport.dart';

/// Owns the operations used by the iOS native button widget.
class NativeButtonController {
  NativeButtonController({RevolutHostApi? host})
    : _host = host ?? RevolutTransport.instance.host;
  final RevolutHostApi _host;
  Future<ButtonCreated> create(ButtonRequest request) {
    RevolutTransport.instance.ensureRegistered();
    return _host.createButton(request);
  }

  Future<bool> cleanup(int viewId) => _host.cleanupButton(viewId);
}
