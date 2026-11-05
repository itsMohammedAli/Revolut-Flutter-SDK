import 'package:flutter/foundation.dart';
import '../callbacks/revolut_callbacks.dart';
import '../models/revolut_pay_models.dart';
import '../platform/platform_factory.dart';
import '../platform/revolut_platform.dart';
import '../widgets/revolut_pay_button.dart';
import '../widgets/revolut_pay_promo_banner.dart';

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
  Future<bool> cleanupButton(int viewId) => _platform.cleanupButton(viewId);
  Future<bool> cleanupAllButtons() => _platform.cleanupAllButtons();

  /// Compatibility operations retain the native SDK's UNSUPPORTED errors.
  Future<Map<String, dynamic>?> createController() =>
      _platform.createController();
  Future<bool> disposeController({required String controllerId}) =>
      _platform.disposeController(controllerId);
  Future<bool> continueConfirmationFlow({required String controllerId}) =>
      _platform.continueConfirmationFlow(controllerId);
  Future<bool> setOrderToken({
    required String orderToken,
    required String controllerId,
  }) => _platform.setOrderToken(controllerId, orderToken);
  Future<bool> setSavePaymentMethodForMerchant({
    required bool savePaymentMethodForMerchant,
    required String controllerId,
  }) => _platform.setSavePaymentMethodForMerchant(
    controllerId,
    savePaymentMethodForMerchant,
  );

  /// Compatibility names: Pigeon registration is synchronous and does not poll.
  bool get isEventChannelReady => isAndroid && _platform.callbacksRegistered;
  Future<bool> setupEventChannel() async {
    if (!isAndroid) return false;
    _platform.ensureCallbacks();
    return _platform.callbacksRegistered;
  }

  Future<bool> waitForEventChannel() async =>
      isAndroid ? setupEventChannel() : true;

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
        if (isAndroid) 'eventChannelReady': isEventChannelReady,
        if (isAndroid || isIOS) 'platformVersion': await getPlatformVersion(),
        if (isAndroid) 'sdkVersion': await getSdkVersion(),
      };
    } catch (error) {
      return {'error': error.toString(), 'platform': name};
    }
  }

  /// Create a Revolut Pay button for the current platform
  ///
  /// [orderToken] - Order token for payment processing
  /// [amount] - Payment amount in minor units (e.g., 1000 for £10.00)
  /// [currency] - Payment currency (e.g., 'GBP', 'EUR', 'USD')
  /// [email] - Customer email address
  /// [buttonParams] - Button customization parameters (Android only)
  /// [shouldRequestShipping] - Whether to request shipping information
  /// [savePaymentMethodForMerchant] - Whether to save payment method
  /// [returnURL] - Return URL for payment completion
  /// [merchantName] - Merchant name to display
  /// [merchantLogoURL] - Merchant logo URL
  /// [additionalData] - Additional data for the payment
  /// Imperative button creation is not supported.
  ///
  /// Render the [CrossPlatformRevolutPayButton] widget instead — it creates and
  /// displays the native Revolut Pay button and reports the payment result.
  @Deprecated('Render the CrossPlatformRevolutPayButton widget instead.')
  Future<Map<String, dynamic>?> createPaymentButton({
    required String orderToken,
    required int amount,
    required String currency,
    required String email,
    ButtonParamsData? buttonParams,
    bool shouldRequestShipping = false,
    bool savePaymentMethodForMerchant = false,
    String? returnURL,
    String? merchantName,
    String? merchantLogoURL,
    Map<String, dynamic>? additionalData,
  }) async {
    throw UnsupportedError(
      'createPaymentButton() is not supported. Render the CrossPlatformRevolutPayButton '
      'widget instead — it displays the native Revolut Pay button and reports results.',
    );
  }

  /// Create a promotional banner (Android only)
  ///
  /// [promoParams] - Promotional banner parameters
  /// [themeId] - Theme ID for the banner
  /// Imperative banner creation is not supported.
  ///
  /// Render the [CrossPlatformRevolutPayPromoBanner] widget instead (Android only).
  @Deprecated('Render the CrossPlatformRevolutPayPromoBanner widget instead.')
  Future<BannerResultData?> createPromotionalBanner({
    PromoBannerParamsData? promoParams,
    String? themeId,
  }) async {
    throw UnsupportedError(
      'createPromotionalBanner() is not supported. Render the CrossPlatformRevolutPayPromoBanner '
      'widget instead (Android only).',
    );
  }

  /// Provide promotional banner widget
  ///
  /// [promoParams] - Parameters for the promotional banner
  /// [themeId] - Optional theme ID for styling
  ///
  /// Returns a Map with banner details
  /// Imperative banner creation is not supported.
  ///
  /// Render the [CrossPlatformRevolutPayPromoBanner] widget instead (Android only).
  @Deprecated('Render the CrossPlatformRevolutPayPromoBanner widget instead.')
  Future<Map<String, dynamic>?> providePromotionalBannerWidget({
    required Map<String, dynamic> promoParams,
    String? themeId,
  }) async {
    throw UnsupportedError(
      'providePromotionalBannerWidget() is not supported. Render the '
      'CrossPlatformRevolutPayPromoBanner widget instead (Android only).',
    );
  }
}
