import 'package:flutter/foundation.dart';
import '../callbacks/revolut_callbacks.dart';
import '../platform/platform_factory.dart';
import '../platform/revolut_platform.dart';

/// Public SDK facade. Native behavior is delegated through one platform contract.
class RevolutSdkBridge {
  static final RevolutSdkBridge _instance = RevolutSdkBridge._internal();
  factory RevolutSdkBridge() => _instance;
  RevolutSdkBridge._internal() : _platform = createRevolutPlatform();

  @visibleForTesting
  RevolutSdkBridge.withPlatform(RevolutPlatform platform)
    : _platform = platform;

  final RevolutPlatform _platform;
  bool get isAndroid => _platform.type == RevolutPlatformType.android;
  bool get isIOS => _platform.type == RevolutPlatformType.ios;
  RevolutCallbacks get callbacks => _platform.callbacks;
  void dispose() => _platform.dispose();

  Future<bool> initialize({
    required String merchantPublicKey,
    String? environment,
  }) => _platform.initialize(
    merchantPublicKey: merchantPublicKey,
    environment: environment,
  );
  Future<bool> processPayment({
    required String orderToken,
    bool savePaymentMethodForMerchant = false,
  }) => _platform.processPayment(
    orderToken: orderToken,
    savePaymentMethodForMerchant: savePaymentMethodForMerchant,
  );
  Future<String> getPlatformVersion() => _platform.getPlatformVersion();
  Future<Map<Object?, dynamic>?> getSdkVersion() => _platform.getSdkVersion();

  /// Whether this SDK instance has registered its native callbacks.
  bool get callbacksRegistered => _platform.callbacksRegistered;

  Future<Map<String, dynamic>> getPluginStatus() async {
    final name = isAndroid
        ? 'android'
        : isIOS
        ? 'ios'
        : 'unknown';
    try {
      return {
        'platform': name,
        'isAndroid': isAndroid,
        'isIOS': isIOS,
        'callbacksRegistered': callbacksRegistered,
        if (isAndroid || isIOS) 'platformVersion': await getPlatformVersion(),
        if (isAndroid) 'sdkVersion': await getSdkVersion(),
      };
    } catch (error) {
      return {'error': error.toString(), 'platform': name};
    }
  }
}
