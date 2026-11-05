import 'package:flutter/services.dart';
import '../../callbacks/revolut_callbacks.dart';
import '../../models/revolut_enums.dart';
import '../../models/revolut_pay_models.dart';
import '../../models/revolut_sdk_exception.dart';
import 'pigeon_android_bridge.dart';

export '../../models/revolut_sdk_exception.dart';

/// Legacy Android interface delegates to the same Pigeon-backed implementation.
class AndroidRevolutSdkBridge implements RevolutSdkBridgePlatformInterface {
  late final PigeonAndroidRevolutSdkBridge _bridge =
      PigeonAndroidRevolutSdkBridge(RevolutCallbacks());
  Future<T> _translate<T>(Future<T> Function() operation) async {
    try {
      return await operation();
    } on PlatformException catch (error) {
      throw RevolutSdkException(
        code: error.code,
        message: error.message ?? 'Native SDK error',
        details: error.details,
      );
    }
  }

  @override
  Future<bool> init({
    required RevolutEnvironment environment,
    required String returnUri,
    required String merchantPublicKey,
    bool requestShipping = false,
    CustomerData? customer,
  }) => _translate(
    () => _bridge.init(
      environment: environment.value,
      merchantPublicKey: merchantPublicKey,
    ),
  );
  @override
  Future<String> getPlatformVersion() => _translate(_bridge.getPlatformVersion);
  @override
  Future<Map<String, dynamic>> getSdkVersion() =>
      _translate(_bridge.getSdkVersion);
  @override
  Future<bool> pay({
    required String orderToken,
    bool savePaymentMethodForMerchant = false,
  }) => _translate(
    () => _bridge.pay(
      orderToken: orderToken,
      savePaymentMethodForMerchant: savePaymentMethodForMerchant,
    ),
  );
  @override
  Future<ControllerResultData> createController() =>
      _translate(_bridge.createController);
  @override
  Future<bool> disposeController({required String controllerId}) =>
      _translate(() => _bridge.disposeController(controllerId: controllerId));
  @override
  Future<bool> continueConfirmationFlow({required String controllerId}) =>
      _translate(
        () => _bridge.continueConfirmationFlow(controllerId: controllerId),
      );
  @override
  Future<bool> setOrderToken({
    required String orderToken,
    required String controllerId,
  }) => _translate(
    () => _bridge.setOrderToken(
      orderToken: orderToken,
      controllerId: controllerId,
    ),
  );
  @override
  Future<bool> setSavePaymentMethodForMerchant({
    required bool savePaymentMethodForMerchant,
    required String controllerId,
  }) => _translate(
    () => _bridge.setSavePaymentMethodForMerchant(
      savePaymentMethodForMerchant: savePaymentMethodForMerchant,
      controllerId: controllerId,
    ),
  );
  @override
  Future<ButtonResultData> provideButton({ButtonParamsData? buttonParams}) =>
      _translate(
        () => _bridge.provideButton(buttonParams: buttonParams?.toMap()),
      );
  @override
  Future<BannerResultData> providePromotionalBannerWidget({
    PromoBannerParamsData? promoParams,
    String? themeId,
  }) => _translate(
    () => _bridge.providePromotionalBannerWidget(
      promoParams: promoParams?.toMap(),
      themeId: themeId,
    ),
  );
}

/// Platform interface for Revolut SDK Bridge
/// This interface defines the contract that Android implementations must follow
abstract class RevolutSdkBridgePlatformInterface {
  /// Replaceable implementation, also used by tests and custom integrations.
  static RevolutSdkBridgePlatformInterface instance = AndroidRevolutSdkBridge();

  /// Continues the confirmation flow
  Future<bool> continueConfirmationFlow({required String controllerId});

  /// Creates a controller for managing confirmation flows
  Future<ControllerResultData> createController();

  /// Disposes a controller
  Future<bool> disposeController({required String controllerId});

  /// Gets the platform version
  Future<String> getPlatformVersion();

  /// Gets the SDK version
  Future<Map<String, dynamic>> getSdkVersion();

  /// Initializes the Revolut Pay SDK
  Future<bool> init({
    required RevolutEnvironment environment,
    required String returnUri,
    required String merchantPublicKey,
    bool requestShipping = false,
    CustomerData? customer,
  });

  /// Initiates a payment flow
  Future<bool> pay({
    required String orderToken,
    bool savePaymentMethodForMerchant = false,
  });

  /// Creates a Revolut Pay button
  Future<ButtonResultData> provideButton({ButtonParamsData? buttonParams});

  /// Creates a promotional banner widget
  Future<BannerResultData> providePromotionalBannerWidget({
    PromoBannerParamsData? promoParams,
    String? themeId,
  });

  /// Sets the order token for a controller
  Future<bool> setOrderToken({
    required String orderToken,
    required String controllerId,
  });

  /// Sets whether to save payment method for merchant
  Future<bool> setSavePaymentMethodForMerchant({
    required bool savePaymentMethodForMerchant,
    required String controllerId,
  });
}
