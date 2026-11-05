import '../callbacks/revolut_callbacks.dart';

enum RevolutPlatformType { android, ios, unsupported }

/// Contract used by the public SDK facade. Pigeon details stay in its adapter.
abstract interface class RevolutPlatform {
  RevolutPlatformType get type;
  RevolutCallbacks get callbacks;
  bool get callbacksRegistered;
  void ensureCallbacks();
  void dispose();
  Future<bool> initialize({
    required String merchantPublicKey,
    String? environment,
  });
  Future<bool> processPayment({
    required String orderToken,
    bool savePaymentMethodForMerchant = false,
  });
  Future<String> getPlatformVersion();
  Future<Map<String, dynamic>> getSdkVersion();
}
