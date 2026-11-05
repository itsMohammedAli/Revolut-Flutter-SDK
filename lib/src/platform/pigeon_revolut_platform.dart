import '../models/callback_models.dart';
import 'package:flutter/services.dart';
import '../callbacks/native_event_dispatcher.dart';
import '../callbacks/revolut_callbacks.dart';
import '../generated/revolut_api.g.dart';
import '../models/revolut_sdk_exception.dart';
import 'message_mappers.dart';
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
    _transport.addSdkListeners(onLog: _onLog, onPayment: _onPayment);
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
    _transport.removeSdkListeners(onLog: _onLog, onPayment: _onPayment);
    _listening = false;
  }

  void _onLog(NativeLogEntry entry) => callbacks.onLog?.call(
    RevolutLogEntry.fromMap({
      'level': entry.level,
      'message': entry.message,
      'timestamp': entry.timestamp,
      'source': entry.source,
    }),
  );
  void _onPayment(NativePaymentResult result) => callbacks.onPaymentResult
      ?.call(RevolutPaymentResult.fromMap(result.toMap()));

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
    return _host.initialize(
      InitializationRequest(
        merchantPublicKey: merchantPublicKey,
        environment: environment,
      ),
    );
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
}
