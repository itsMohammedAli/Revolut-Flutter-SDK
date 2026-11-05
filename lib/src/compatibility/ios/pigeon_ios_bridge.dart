import 'package:flutter/services.dart';
import '../../generated/revolut_api.g.dart';
import '../../models/revolut_sdk_exception.dart';
import '../../platform/legacy_converters.dart';
import '../../platform/revolut_transport.dart';
import 'platform_interface.dart';

export '../../models/revolut_sdk_exception.dart';

/// Adapts the legacy iOS public API to the shared, typed Pigeon contract.
class PigeonIosRevolutSdkBridge extends RevolutSdkBridgePlatform {
  final RevolutTransport _transport = RevolutTransport.instance;
  RevolutHostApi get _host {
    _transport.ensureRegistered();
    return _transport.host;
  }

  Future<T> _translate<T>(Future<T> Function() operation) async {
    try {
      return await operation();
    } on PlatformException catch (error) {
      throw RevolutSdkException(
        code: error.code,
        message: error.message ?? 'Unknown error occurred',
        details: error.details,
      );
    }
  }

  @override
  Future<bool> cleanupAllButtonsIos() => _host.cleanupAllButtons();
  @override
  Future<bool> cleanupButtonIos(int viewId) => _host.cleanupButton(viewId);
  @override
  Future<bool> continueConfirmationFlowIos({required String controllerId}) =>
      _translate(() => _host.continueConfirmationFlow(controllerId));
  @override
  Future<Map<String, dynamic>?> createControllerIos() => _translate(
    () async => Map<String, dynamic>.from(await _host.createController()),
  );

  @override
  Future<Map<String, dynamic>?> createRevolutPayButtonIos({
    required String orderToken,
    required int amount,
    required String currency,
    required String email,
    bool shouldRequestShipping = false,
    bool savePaymentMethodForMerchant = false,
    String? returnURL,
    String? merchantName,
    String? merchantLogoURL,
    Map<String, dynamic>? additionalData,
  }) async => (await _host.createButton(
    ButtonRequest(
      orderToken: orderToken,
      amount: amount,
      currency: currency,
      email: email,
      shouldRequestShipping: shouldRequestShipping,
      savePaymentMethodForMerchant: savePaymentMethodForMerchant,
      returnURL: returnURL,
      merchantName: merchantName,
      merchantLogoURL: merchantLogoURL,
      additionalData: additionalData,
    ),
  )).toMap();

  @override
  Future<bool> disposeControllerIos({required String controllerId}) =>
      _translate(() => _host.disposeController(controllerId));
  @override
  Future<String?> getPlatformVersionIos() =>
      _translate(_host.getPlatformVersion);
  @override
  Future<Map<String, dynamic>?> getSdkVersionIos() => _translate(
    () async => {
      ...(await _host.getSdkVersion()).toMap(),
      'message': 'Revolut Pay SDK version information',
    },
  );
  @override
  Future<bool> initializeIos({
    required String merchantPublicKey,
    String? environment,
  }) => _translate(() async {
    final initialized = await _host.initialize(
      InitializationRequest(
        merchantPublicKey: merchantPublicKey,
        environment: environment,
      ),
    );
    _transport.initialized = initialized;
    return initialized;
  });
  @override
  Future<Map<String, dynamic>?> payIos({
    required String orderToken,
    bool savePaymentMethodForMerchant = false,
  }) => _translate(
    () async => (await _host.pay(
      PaymentRequest(
        orderToken: orderToken,
        savePaymentMethodForMerchant: savePaymentMethodForMerchant,
        requestShipping: false,
      ),
    )).toMap(),
  );
  @override
  Future<Map<String, dynamic>?> providePromotionalBannerWidgetIos({
    required Map<String, dynamic> promoParams,
    String? themeId,
  }) => _translate(
    () async => Map<String, dynamic>.from(
      await _host.providePromotionalBannerWidget(promoParams, themeId),
    ),
  );
  @override
  Future<bool> setOrderTokenIos({
    required String orderToken,
    required String controllerId,
  }) => _translate(() => _host.setOrderToken(controllerId, orderToken));
  @override
  Future<bool> setSavePaymentMethodForMerchantIos({
    required bool savePaymentMethodForMerchant,
    required String controllerId,
  }) => _translate(
    () => _host.setSavePaymentMethodForMerchant(
      controllerId,
      savePaymentMethodForMerchant,
    ),
  );
}
