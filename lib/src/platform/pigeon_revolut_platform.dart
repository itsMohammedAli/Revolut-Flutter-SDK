import 'package:flutter/services.dart';
import '../callbacks/native_event_dispatcher.dart';
import '../callbacks/revolut_callbacks.dart';
import '../generated/revolut_api.g.dart';
import '../models/revolut_sdk_exception.dart';
import 'legacy_converters.dart';
import 'revolut_platform.dart';
import 'revolut_transport.dart';

/// Shared Android/iOS implementation of the facade's platform contract.
class PigeonRevolutPlatform implements RevolutPlatform {
  PigeonRevolutPlatform({
    required this.type,
    RevolutHostApi? host,
    RevolutTransport? transport,
    RevolutCallbacks? callbacks,
  }) : _transport = transport ?? RevolutTransport.instance,
       _host = host ?? (transport ?? RevolutTransport.instance).host,
       callbacks = callbacks ?? RevolutCallbacks();

  @override
  final RevolutPlatformType type;
  final RevolutHostApi _host;
  final RevolutTransport _transport;
  @override
  final RevolutCallbacks callbacks;
  late final NativeEventDispatcher _dispatcher = NativeEventDispatcher(
    callbacks,
  );
  bool _listening = false;

  void _checkSupported() {
    if (type == RevolutPlatformType.unsupported) {
      throw UnsupportedError('Platform not supported');
    }
  }

  @override
  bool get callbacksRegistered => _listening;
  @override
  void ensureCallbacks() {
    _checkSupported();
    _transport.ensureRegistered();
    if (type == RevolutPlatformType.android) {
      _transport.addEventListener(_dispatcher.handleEvent);
    }
    _listening = true;
  }

  @override
  void dispose() {
    if (_listening && type == RevolutPlatformType.android) {
      _transport.removeEventListener(_dispatcher.handleEvent);
    }
    _listening = false;
  }

  Future<T> _invoke<T>(Future<T> Function() operation) async {
    _checkSupported();
    ensureCallbacks();
    try {
      return await operation();
    } on PlatformException catch (error) {
      if (type == RevolutPlatformType.ios) {
        throw RevolutSdkException(
          code: error.code,
          message: error.message ?? 'Native SDK error',
          details: error.details,
        );
      }
      rethrow;
    }
  }

  @override
  Future<bool> initialize({
    required String merchantPublicKey,
    String? environment,
  }) => _invoke(() async {
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
  Future<bool> processPayment({
    required String orderToken,
    bool savePaymentMethodForMerchant = false,
  }) => _invoke(() async {
    final result = await _host.pay(
      PaymentRequest(
        orderToken: orderToken,
        savePaymentMethodForMerchant: savePaymentMethodForMerchant,
        requestShipping: false,
      ),
    );
    return result.status == 'initiated';
  });
  @override
  Future<String> getPlatformVersion() => _invoke(_host.getPlatformVersion);
  @override
  Future<Map<String, dynamic>> getSdkVersion() => _invoke(
    () async => {
      ...(await _host.getSdkVersion()).toMap(),
      if (type == RevolutPlatformType.ios)
        'message': 'Revolut Pay SDK version information',
    },
  );
  @override
  Future<bool> cleanupButton(int viewId) =>
      _invoke(() => _host.cleanupButton(viewId));
  @override
  Future<bool> cleanupAllButtons() => _invoke(_host.cleanupAllButtons);
  @override
  Future<Map<String, dynamic>> createController() => _invoke(
    () async => Map<String, dynamic>.from(await _host.createController()),
  );
  @override
  Future<bool> disposeController(String controllerId) =>
      _invoke(() => _host.disposeController(controllerId));
  @override
  Future<bool> continueConfirmationFlow(String controllerId) =>
      _invoke(() => _host.continueConfirmationFlow(controllerId));
  @override
  Future<bool> setOrderToken(String controllerId, String orderToken) =>
      _invoke(() => _host.setOrderToken(controllerId, orderToken));
  @override
  Future<bool> setSavePaymentMethodForMerchant(
    String controllerId,
    bool save,
  ) => _invoke(() => _host.setSavePaymentMethodForMerchant(controllerId, save));
}
