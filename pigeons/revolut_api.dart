import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/generated/revolut_api.g.dart',
    kotlinOut:
        'android/src/main/kotlin/com/revolutpay/flutter/generated/RevolutApi.g.kt',
    kotlinOptions: KotlinOptions(package: 'com.revolutpay.flutter.generated'),
    swiftOut:
        'ios/revolut_sdk_bridge/Sources/revolut_sdk_bridge/Generated/RevolutApi.g.swift',
  ),
)
class InitializationRequest {
  InitializationRequest({required this.merchantPublicKey, this.environment});
  String merchantPublicKey;
  String? environment;
}

class PaymentRequest {
  PaymentRequest({
    required this.orderToken,
    required this.savePaymentMethodForMerchant,
    this.returnURL,
    this.preferredMode,
    required this.requestShipping,
  });
  String orderToken;
  bool savePaymentMethodForMerchant;
  String? returnURL;
  String? preferredMode;
  bool requestShipping;
}

class PaymentStarted {
  PaymentStarted({required this.status, required this.orderToken});
  String status;
  String orderToken;
}

class SdkInfo {
  SdkInfo({
    required this.version,
    required this.platform,
    required this.buildNumber,
  });
  String version;
  String platform;
  String buildNumber;
}

class ButtonRequest {
  ButtonRequest({
    required this.orderToken,
    required this.amount,
    required this.currency,
    required this.email,
    required this.shouldRequestShipping,
    required this.savePaymentMethodForMerchant,
    this.returnURL,
    this.merchantName,
    this.merchantLogoURL,
    this.additionalData,
  });
  String orderToken;
  int amount;
  String currency;
  String email;
  bool shouldRequestShipping;
  bool savePaymentMethodForMerchant;
  String? returnURL;
  String? merchantName;
  String? merchantLogoURL;
  Map<String, Object?>? additionalData;
}

class ButtonCreated {
  ButtonCreated({required this.viewId, required this.request});
  int viewId;
  ButtonRequest request;
}

class NativePaymentResult {
  NativePaymentResult({
    required this.success,
    required this.message,
    required this.error,
    required this.timestamp,
    this.viewId,
    this.orderToken,
  });
  bool success;
  String message;
  String error;
  int timestamp;
  int? viewId;
  String? orderToken;
}

class NativeLogEntry {
  NativeLogEntry({
    required this.level,
    required this.message,
    required this.timestamp,
    required this.source,
  });
  String level;
  String message;
  int timestamp;
  String source;
}

// Extensible metadata for the existing Android lifecycle/banner callbacks.
class NativeEvent {
  NativeEvent({required this.name, required this.data});
  String name;
  Map<String, Object?> data;
}

@HostApi()
abstract class RevolutHostApi {
  bool initialize(InitializationRequest request);
  String getPlatformVersion();
  SdkInfo getSdkVersion();
  PaymentStarted pay(PaymentRequest request);
  ButtonCreated createButton(ButtonRequest request);
  bool cleanupButton(int viewId);
  bool cleanupAllButtons();

  // Compatibility operations: native SDKs report UNSUPPORTED for these.
  Map<String, Object?> createController();
  bool disposeController(String controllerId);
  bool continueConfirmationFlow(String controllerId);
  bool setOrderToken(String controllerId, String orderToken);
  bool setSavePaymentMethodForMerchant(String controllerId, bool save);
  Map<String, Object?> provideButton(Map<String, Object?>? params);
  Map<String, Object?> providePromotionalBannerWidget(
    Map<String, Object?>? params,
    String? themeId,
  );
}

@FlutterApi()
abstract class RevolutFlutterApi {
  @asyncCallback
  void onPaymentResult(NativePaymentResult result);
  @asyncCallback
  void onLog(NativeLogEntry entry);
  @asyncCallback
  void onEvent(NativeEvent event);
}
