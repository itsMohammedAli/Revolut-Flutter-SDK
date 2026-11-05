import 'package:freezed_annotation/freezed_annotation.dart';

part 'ios_button_config.freezed.dart';
part 'ios_button_config.g.dart';

@freezed
abstract class RevolutPayButtonConfigIos with _$RevolutPayButtonConfigIos {
  const RevolutPayButtonConfigIos._();
  const factory RevolutPayButtonConfigIos({
    required String orderToken,
    required int amount,
    required String currency,
    required String email,
    @Default(false) bool shouldRequestShipping,
    @Default(false) bool savePaymentMethodForMerchant,
    String? returnURL,
    String? merchantName,
    String? merchantLogoURL,
    Map<String, dynamic>? additionalData,
  }) = _RevolutPayButtonConfigIos;
  factory RevolutPayButtonConfigIos.fromJson(Map<String, dynamic> json) =>
      _$RevolutPayButtonConfigIosFromJson(json);
  Map<String, dynamic> toMap() => toJson();
}
