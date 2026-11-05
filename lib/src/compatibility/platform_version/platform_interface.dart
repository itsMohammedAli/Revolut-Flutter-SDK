import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'pigeon_bridge.dart';

abstract class RevolutSdkBridgePlatform extends PlatformInterface {
  /// Constructs a RevolutSdkBridgePlatform.
  RevolutSdkBridgePlatform() : super(token: _token);

  static final Object _token = Object();

  static RevolutSdkBridgePlatform _instance = PigeonRevolutSdkBridge();

  /// The default instance of [RevolutSdkBridgePlatform] to use.
  ///
  /// Defaults to [PigeonRevolutSdkBridge].
  static RevolutSdkBridgePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [RevolutSdkBridgePlatform] when
  /// they register themselves.
  static set instance(RevolutSdkBridgePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
