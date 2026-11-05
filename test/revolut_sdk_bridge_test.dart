import 'package:flutter/services.dart';
import 'package:revolut_sdk_bridge/src/models/ios_button_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:revolut_sdk_bridge/revolut_sdk_bridge.dart';

void main() {
  group('ButtonParamsData', () {
    test('toMap exposes documented defaults', () {
      final map = const ButtonParamsData().toMap();

      expect(map['radius'], 'MEDIUM');
      expect(map['size'], 'LARGE');
      expect(map['boxText'], 'NONE');
      expect(map['boxTextCurrency'], isNull);
      expect(map['variantModes'], isNull);
    });

    test('fromMap round-trips all fields', () {
      const params = ButtonParamsData(
        radius: ButtonRadius.large,
        size: ButtonSize.small,
        boxText: BoxText.getCashbackValue,
        boxTextCurrency: 'EUR',
        variantModes: VariantModesData(
          darkTheme: ButtonVariant.light,
          lightTheme: ButtonVariant.dark,
        ),
      );

      final restored = ButtonParamsData.fromMap(params.toMap());

      expect(restored.radius, ButtonRadius.large);
      expect(restored.size, ButtonSize.small);
      expect(restored.boxText, BoxText.getCashbackValue);
      expect(restored.boxTextCurrency, 'EUR');
      expect(restored.variantModes?.darkTheme, ButtonVariant.light);
      expect(restored.variantModes?.lightTheme, ButtonVariant.dark);
    });

    test('fromMap falls back to defaults on unknown values', () {
      final restored = ButtonParamsData.fromMap({
        'radius': 'BOGUS',
        'size': null,
        'boxText': 'NOPE',
      });

      expect(restored.radius, ButtonRadius.medium);
      expect(restored.size, ButtonSize.large);
      expect(restored.boxText, BoxText.none);
    });
  });

  group('OrderResultData', () {
    test('fromMap parses optional fields', () {
      final result = OrderResultData.fromMap({
        'success': false,
        'error': 'boom',
        'cause': 'network',
      });

      expect(result.success, isFalse);
      expect(result.orderId, isNull);
      expect(result.error, 'boom');
      expect(result.cause, 'network');
    });
  });
  test(
    'nested banner models serialize as native maps and round-trip by value',
    () {
      const banner = PromoBannerParamsData(
        transactionId: 'order-1',
        paymentAmount: 1500,
        currency: RevolutCurrency.eur,
        customer: CustomerData(
          email: 'buyer@example.com',
          country: 'FR',
          dateOfBirth: DateOfBirthData(day: 2, month: 3, year: 1990),
        ),
      );
      final map = banner.toMap();
      expect(map['currency'], 'EUR');
      expect(map['customer'], isA<Map<String, dynamic>>());
      expect((map['customer'] as Map)['dateOfBirth'], {
        'day': 2,
        'month': 3,
        'year': 1990,
      });
      expect(PromoBannerParamsData.fromMap(map), banner);
      final changed = banner.copyWith.customer!(email: 'changed@example.com');
      expect(changed.customer?.email, 'changed@example.com');
      expect(banner.customer?.email, 'buyer@example.com');
      expect(changed, isNot(banner));
    },
  );

  test('nullable result fields can be cleared with copyWith', () {
    const result = OrderResultData(success: false, error: 'declined');
    final updated = result.copyWith(success: true, error: null);
    expect(updated, const OrderResultData(success: true));
    expect(result.error, 'declined');
  });

  test('callback JSON preserves native timestamps and log-level parsing', () {
    final log = RevolutLogEntry.fromMap({
      'level': 'wArNiNg',
      'timestamp': 1234,
      'message': 'ready',
    });
    expect(log.level, RevolutLogLevel.warning);
    expect(log.timestamp.millisecondsSinceEpoch, 1234);
    expect(log.toJson()['timestamp'], 1234);
    expect(log.toJson()['level'], 'WARNING');
    expect(log.source, 'Unknown');
    expect(RevolutLogEntry.fromJson(log.toJson()), log);
    expect(
      RevolutLogEntry.fromMap({'level': 'unknown'}).level,
      RevolutLogLevel.info,
    );
    expect(RevolutLogEntry.fromMap({}).timestamp.millisecondsSinceEpoch, 0);
    final result = RevolutPaymentResult.fromMap({
      'success': true,
      'timestamp': 1234.0,
    });
    expect(result.timestamp.millisecondsSinceEpoch, 1234);
    expect(RevolutPaymentResult.fromJson(result.toJson()), result);
    expect(result.message, '');
    expect(result.error, '');
  });
  test('iOS configuration stays codec-compatible with immutable metadata', () {
    const config = RevolutPayButtonConfigIos(
      orderToken: 'token',
      amount: 1500,
      currency: 'EUR',
      email: 'buyer@example.com',
      additionalData: {'reference': 'ref-1'},
    );
    expect(
      () => config.additionalData!['reference'] = 'changed',
      throwsUnsupportedError,
    );
    final map = config.toMap();
    const codec = StandardMessageCodec();
    expect(codec.decodeMessage(codec.encodeMessage(map)), map);
    expect(RevolutPayButtonConfigIos.fromJson(map), config);
    final changed = config.copyWith(additionalData: null, amount: 2000);
    expect(changed.additionalData, isNull);
    expect(config.additionalData?['reference'], 'ref-1');
  });
}
