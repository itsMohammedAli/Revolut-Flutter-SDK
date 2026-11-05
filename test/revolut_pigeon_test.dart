import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:revolut_sdk_bridge/revolut_sdk_bridge.dart';
import 'package:revolut_sdk_bridge/src/platform/pigeon_revolut_platform.dart';
import 'package:revolut_sdk_bridge/src/platform/revolut_platform.dart';
import 'package:revolut_sdk_bridge/src/platform/native_button_controller.dart';
import 'package:revolut_sdk_bridge/src/platform/message_mappers.dart';
import 'package:revolut_sdk_bridge/src/generated/revolut_api.g.dart';
import 'package:revolut_sdk_bridge/src/platform/revolut_transport.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
  const codec = RevolutHostApi.pigeonChannelCodec;
  final mockedChannels = <String>[];

  void mockHost(String method, Object? Function(Object?) handler) {
    final name = 'dev.flutter.pigeon.revolut_sdk_bridge.RevolutHostApi.$method';
    mockedChannels.add(name);
    messenger.setMockDecodedMessageHandler<Object?>(
      BasicMessageChannel<Object?>(name, codec),
      (message) async => handler(message),
    );
  }

  Future<void> nativeCallback(String method, Object value) async {
    final done = Completer<void>();
    messenger.handlePlatformMessage(
      'dev.flutter.pigeon.revolut_sdk_bridge.RevolutFlutterApi.$method',
      RevolutFlutterApi.pigeonChannelCodec.encodeMessage([value]),
      (reply) {
        final envelope =
            RevolutFlutterApi.pigeonChannelCodec.decodeMessage(reply) as List;
        expect(envelope, isEmpty);
        done.complete();
      },
    );
    await done.future;
  }

  tearDown(() {
    for (final name in mockedChannels) {
      messenger.setMockMessageHandler(name, null);
    }
    mockedChannels.clear();
  });

  test('platform version API uses the generated host protocol', () async {
    mockHost('getPlatformVersion', (_) => ['42']);
    expect(
      await PigeonRevolutPlatform(
        type: RevolutPlatformType.android,
      ).getPlatformVersion(),
      '42',
    );
  });

  test(
    'initialization and payment use typed requests across separate adapters',
    () async {
      mockHost('initialize', (message) {
        final request = (message as List).single as InitializationRequest;
        expect(request.merchantPublicKey, 'public-key');
        expect(request.environment, 'sandbox');
        return [true];
      });
      mockHost('pay', (message) {
        final request = (message as List).single as PaymentRequest;
        expect(request.orderToken, 'order-token');
        expect(request.savePaymentMethodForMerchant, isTrue);
        return [
          PaymentStarted(status: 'initiated', orderToken: request.orderToken),
        ];
      });
      final first = PigeonRevolutPlatform(type: RevolutPlatformType.android);
      final second = PigeonRevolutPlatform(type: RevolutPlatformType.android);
      addTearDown(first.dispose);
      addTearDown(second.dispose);
      expect(
        await first.initialize(
          environment: 'sandbox',
          merchantPublicKey: 'public-key',
        ),
        isTrue,
      );

      expect(
        await second.processPayment(
          orderToken: 'order-token',
          savePaymentMethodForMerchant: true,
        ),
        isTrue,
      );
    },
  );

  test(
    'native error codes survive Pigeon and iOS exception translation',
    () async {
      mockHost(
        'pay',
        (_) => [
          'NOT_INITIALIZED',
          'Initialize first',
          {'reason': 'missing-key'},
        ],
      );
      final android = PigeonRevolutPlatform(type: RevolutPlatformType.android);
      addTearDown(android.dispose);
      await expectLater(
        android.processPayment(orderToken: 'token'),
        throwsA(
          isA<PlatformException>().having(
            (e) => e.code,
            'code',
            'NOT_INITIALIZED',
          ),
        ),
      );
      final ios = PigeonRevolutPlatform(type: RevolutPlatformType.ios);
      addTearDown(ios.dispose);
      await expectLater(
        ios.processPayment(orderToken: 'token'),
        throwsA(
          isA<RevolutSdkException>().having(
            (e) => e.code,
            'code',
            'NOT_INITIALIZED',
          ),
        ),
      );
    },
  );

  test(
    'iOS typed button reply preserves the public configuration map',
    () async {
      mockHost('createButton', (message) {
        final request = (message as List).single as ButtonRequest;
        expect(request.amount, 1500);
        expect(request.additionalData?['nested'], {'count': 2});
        return [ButtonCreated(viewId: 7, request: request)];
      });
      final config = (await NativeButtonController().create(
        ButtonRequest(
          orderToken: 'token',
          amount: 1500,
          currency: 'EUR',
          email: 'buyer@example.com',
          shouldRequestShipping: false,
          savePaymentMethodForMerchant: false,
          additionalData: {
            'nested': {'count': 2},
          },
        ),
      )).toMap();
      expect(config['viewId'], 7);
      expect(config['buttonCreated'], isTrue);
      expect(config['returnURL'], 'revolut-sdk-bridge://revolut-pay');
      expect(config['additionalData'], {
        'nested': {'count': 2},
      });
    },
  );

  test(
    'payment results route to their button; disposed listeners stay removed',
    () async {
      final transport = RevolutTransport.instance;
      final received = <int>[];
      transport.addButtonListener(10, (_) => received.add(10));
      transport.addButtonListener(20, (_) => received.add(20));
      addTearDown(() {
        transport.removeButtonListener(10);
        transport.removeButtonListener(20);
      });
      final result = NativePaymentResult(
        success: false,
        message: 'Cancelled',
        error: 'user_abandoned_payment',
        timestamp: 123,
        viewId: 20,
      );
      await nativeCallback('onPaymentResult', result);
      expect(received, [20]);
      transport.removeButtonListener(20);
      await nativeCallback('onPaymentResult', result);
      expect(received, [20]);
      result.viewId = 10;
      await nativeCallback('onPaymentResult', result);
      expect(received, [20, 10]);
    },
  );

  test(
    'one event receiver does not duplicate a registered adapter callback',
    () async {
      var count = 0;
      final callbacks = RevolutCallbacks()..onOrderCompleted = (_) => count++;
      final adapter = PigeonRevolutPlatform(
        type: RevolutPlatformType.android,
        callbacks: callbacks,
      );
      adapter.ensureCallbacks();
      adapter.ensureCallbacks();
      await nativeCallback(
        'onEvent',
        NativeEvent(name: 'onOrderCompleted', data: {'success': true}),
      );
      expect(count, 1);
      adapter.dispose();
      await nativeCallback(
        'onEvent',
        NativeEvent(name: 'onOrderCompleted', data: {'success': true}),
      );
      expect(count, 1);
    },
  );

  test('disposing SDK listeners leaves button callbacks active', () async {
    var global = 0;
    var button = 0;
    final sdk = PigeonRevolutPlatform(type: RevolutPlatformType.ios);
    sdk.callbacks.onPaymentResult = (_) => global++;
    sdk.ensureCallbacks();
    final transport = RevolutTransport.instance;
    transport.addButtonListener(99, (_) => button++);
    addTearDown(() {
      sdk.dispose();
      transport.removeButtonListener(99);
    });
    final result = NativePaymentResult(
      success: true,
      message: 'Paid',
      error: '',
      timestamp: 123,
    );
    await nativeCallback('onPaymentResult', result);
    expect(global, 1);
    sdk.dispose();
    result.viewId = 99;
    await nativeCallback('onPaymentResult', result);
    expect(button, 1);
    expect(global, 1);
  });

  test(
    'shared platform routes facade payment and callbacks across disposal/reinitialization',
    () async {
      mockHost('initialize', (_) => [true]);
      mockHost('pay', (message) {
        final request = (message as List).single as PaymentRequest;
        return [
          PaymentStarted(status: 'initiated', orderToken: request.orderToken),
        ];
      });
      var count = 0;
      final platform = PigeonRevolutPlatform(type: RevolutPlatformType.android);
      final sdk = RevolutSdkBridge.withPlatform(platform);
      sdk.callbacks.onOrderCompleted = (_) => count++;
      expect(sdk.callbacksRegistered, isFalse);
      await sdk.initialize(merchantPublicKey: 'key', environment: 'sandbox');
      expect(await sdk.processPayment(orderToken: 'token'), isTrue);
      expect(sdk.callbacksRegistered, isTrue);
      final event = NativeEvent(
        name: 'onOrderCompleted',
        data: {'success': true},
      );
      await nativeCallback('onEvent', event);
      expect(count, 1);
      sdk.dispose();
      expect(sdk.callbacksRegistered, isFalse);
      await nativeCallback('onEvent', event);
      expect(count, 1);
      await sdk.initialize(merchantPublicKey: 'key');
      await sdk.initialize(merchantPublicKey: 'key');
      await nativeCallback('onEvent', event);
      expect(count, 2);
      sdk.dispose();
    },
  );

  test(
    'shared iOS facade preserves structured errors and registers callbacks',
    () async {
      mockHost('pay', (_) => ['NOT_INITIALIZED', 'Initialize first', null]);
      final platform = PigeonRevolutPlatform(type: RevolutPlatformType.ios);
      final sdk = RevolutSdkBridge.withPlatform(platform);
      addTearDown(sdk.dispose);
      await expectLater(
        sdk.processPayment(orderToken: 'token'),
        throwsA(
          isA<RevolutSdkException>().having(
            (error) => error.code,
            'code',
            'NOT_INITIALIZED',
          ),
        ),
      );
      expect(sdk.isIOS, isTrue);
      expect(sdk.callbacksRegistered, isTrue);
    },
  );

  test(
    'unsupported platforms reject calls before reaching the native host',
    () async {
      var calls = 0;
      mockHost('initialize', (_) {
        calls++;
        return [true];
      });
      final sdk = RevolutSdkBridge.withPlatform(
        PigeonRevolutPlatform(type: RevolutPlatformType.unsupported),
      );
      addTearDown(sdk.dispose);
      await expectLater(
        sdk.initialize(merchantPublicKey: 'key'),
        throwsUnsupportedError,
      );
      expect(calls, 0);
      expect(await sdk.getPluginStatus(), {
        'platform': 'unknown',
        'isAndroid': false,
        'isIOS': false,
        'callbacksRegistered': false,
      });
    },
  );
  test('SDK log and payment listeners are scoped to each instance', () async {
    final first = PigeonRevolutPlatform(type: RevolutPlatformType.ios);
    final second = PigeonRevolutPlatform(type: RevolutPlatformType.ios);
    addTearDown(first.dispose);
    addTearDown(second.dispose);
    final logs = <String>[];
    final payments = <String>[];
    first.callbacks.onLog = (entry) => logs.add('first:${entry.message}');
    second.callbacks.onLog = (entry) => logs.add('second:${entry.message}');
    first.callbacks.onPaymentResult = (_) => payments.add('first');
    second.callbacks.onPaymentResult = (_) => payments.add('second');
    first.ensureCallbacks();
    second.ensureCallbacks();
    first.ensureCallbacks();
    final log = NativeLogEntry(
      level: 'INFO',
      message: 'ready',
      timestamp: 123,
      source: 'test',
    );
    await nativeCallback('onLog', log);
    expect(logs, ['first:ready', 'second:ready']);
    first.dispose();
    await nativeCallback(
      'onPaymentResult',
      NativePaymentResult(
        success: true,
        message: 'Paid',
        error: '',
        timestamp: 123,
      ),
    );
    expect(payments, ['second']);
    await nativeCallback('onLog', log);
    expect(logs, ['first:ready', 'second:ready', 'second:ready']);
  });
}
