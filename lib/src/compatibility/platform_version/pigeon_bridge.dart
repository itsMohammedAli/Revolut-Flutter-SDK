import '../../generated/revolut_api.g.dart';
import 'platform_interface.dart';

/// An implementation of [RevolutSdkBridgePlatform] that uses Pigeon.
class PigeonRevolutSdkBridge extends RevolutSdkBridgePlatform {
  final RevolutHostApi _host = RevolutHostApi();

  @override
  Future<String?> getPlatformVersion() async {
    final version = await _host.getPlatformVersion();
    return version;
  }
}
