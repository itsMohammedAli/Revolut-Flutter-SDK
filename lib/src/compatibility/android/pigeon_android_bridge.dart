import '../../callbacks/native_event_dispatcher.dart';
import '../../callbacks/revolut_callbacks.dart';
import '../../generated/revolut_api.g.dart';
import '../../models/revolut_pay_models.dart';
import '../../platform/legacy_converters.dart';
import '../../platform/revolut_transport.dart';

/// Compatibility adapter backed by the shared, generated Pigeon API.
class PigeonAndroidRevolutSdkBridge {
  final RevolutCallbacks _callbacks;
  late final NativeEventDispatcher _dispatcher = NativeEventDispatcher(
    _callbacks,
  );
  final RevolutTransport _transport = RevolutTransport.instance;
  RevolutHostApi get _host => _transport.host;
  PigeonAndroidRevolutSdkBridge(this._callbacks) {
    ensureEventChannelReady();
  }
  RevolutCallbacks get callbacks => _callbacks;
  bool get isEventChannelReady => _transport.callbacksRegistered;
  bool get isInitialized => _transport.initialized;
  void ensureEventChannelReady() =>
      _transport.addEventListener(_dispatcher.handleEvent);
  void dispose() => _transport.removeEventListener(_dispatcher.handleEvent);

  Future<bool> init({
    required String environment,
    required String merchantPublicKey,
  }) async {
    ensureEventChannelReady();
    final result = await _host.initialize(
      InitializationRequest(
        merchantPublicKey: merchantPublicKey,
        environment: environment,
      ),
    );
    _transport.initialized = result;
    return result;
  }

  Future<String> getPlatformVersion() => _host.getPlatformVersion();
  Future<Map<String, dynamic>> getSdkVersion() async =>
      (await _host.getSdkVersion()).toMap();
  Future<bool> pay({
    required String orderToken,
    bool savePaymentMethodForMerchant = false,
  }) async {
    final result = await _host.pay(
      PaymentRequest(
        orderToken: orderToken,
        savePaymentMethodForMerchant: savePaymentMethodForMerchant,
        requestShipping: false,
      ),
    );
    return result.status == 'initiated';
  }

  Future<ControllerResultData> createController() async =>
      ControllerResultData.fromMap(
        Map<String, dynamic>.from(await _host.createController()),
      );
  Future<bool> disposeController({required String controllerId}) =>
      _host.disposeController(controllerId);
  Future<bool> continueConfirmationFlow({required String controllerId}) =>
      _host.continueConfirmationFlow(controllerId);
  Future<bool> setOrderToken({
    required String controllerId,
    required String orderToken,
  }) => _host.setOrderToken(controllerId, orderToken);
  Future<bool> setSavePaymentMethodForMerchant({
    required String controllerId,
    required bool savePaymentMethodForMerchant,
  }) => _host.setSavePaymentMethodForMerchant(
    controllerId,
    savePaymentMethodForMerchant,
  );
  Future<ButtonResultData> provideButton({
    Map<String, dynamic>? buttonParams,
  }) async => ButtonResultData.fromMap(
    Map<String, dynamic>.from(await _host.provideButton(buttonParams)),
  );
  Future<BannerResultData> providePromotionalBannerWidget({
    Map<String, dynamic>? promoParams,
    String? themeId,
  }) async => BannerResultData.fromMap(
    Map<String, dynamic>.from(
      await _host.providePromotionalBannerWidget(promoParams, themeId),
    ),
  );
}
