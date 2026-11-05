import 'package:freezed_annotation/freezed_annotation.dart';
import 'revolut_enums.dart';

part 'revolut_pay_models.freezed.dart';
part 'revolut_pay_models.g.dart';

@freezed
abstract class CustomerData with _$CustomerData {
  const CustomerData._();
  const factory CustomerData({
    String? name,
    String? email,
    String? phone,
    DateOfBirthData? dateOfBirth,
    String? country,
  }) = _CustomerData;
  factory CustomerData.fromJson(Map<String, dynamic> json) =>
      _$CustomerDataFromJson(json);
  factory CustomerData.fromMap(Map<String, dynamic> map) =>
      CustomerData.fromJson(map);
  Map<String, dynamic> toMap() => toJson();
}

@freezed
abstract class DateOfBirthData with _$DateOfBirthData {
  const DateOfBirthData._();
  const factory DateOfBirthData({
    required int day,
    required int month,
    required int year,
  }) = _DateOfBirthData;
  factory DateOfBirthData.fromJson(Map<String, dynamic> json) =>
      _$DateOfBirthDataFromJson(json);
  factory DateOfBirthData.fromMap(Map<String, dynamic> map) =>
      DateOfBirthData.fromJson(map);
  Map<String, dynamic> toMap() => toJson();
}

@freezed
abstract class ButtonParamsData with _$ButtonParamsData {
  const ButtonParamsData._();
  const factory ButtonParamsData({
    @JsonKey(unknownEnumValue: ButtonRadius.medium)
    @Default(ButtonRadius.medium)
    ButtonRadius radius,
    @JsonKey(unknownEnumValue: ButtonSize.large)
    @Default(ButtonSize.large)
    ButtonSize size,
    @JsonKey(unknownEnumValue: BoxText.none)
    @Default(BoxText.none)
    BoxText boxText,
    String? boxTextCurrency,
    VariantModesData? variantModes,
  }) = _ButtonParamsData;
  factory ButtonParamsData.fromJson(Map<String, dynamic> json) =>
      _$ButtonParamsDataFromJson(json);
  factory ButtonParamsData.fromMap(Map<String, dynamic> map) =>
      ButtonParamsData.fromJson(map);
  Map<String, dynamic> toMap() => toJson();
}

@freezed
abstract class VariantModesData with _$VariantModesData {
  const VariantModesData._();
  const factory VariantModesData({
    @JsonKey(unknownEnumValue: ButtonVariant.dark)
    @Default(ButtonVariant.dark)
    ButtonVariant darkTheme,
    @JsonKey(unknownEnumValue: ButtonVariant.light)
    @Default(ButtonVariant.light)
    ButtonVariant lightTheme,
  }) = _VariantModesData;
  factory VariantModesData.fromJson(Map<String, dynamic> json) =>
      _$VariantModesDataFromJson(json);
  factory VariantModesData.fromMap(Map<String, dynamic> map) =>
      VariantModesData.fromJson(map);
  Map<String, dynamic> toMap() => toJson();
}

@freezed
abstract class PromoBannerParamsData with _$PromoBannerParamsData {
  const PromoBannerParamsData._();
  const factory PromoBannerParamsData({
    required String transactionId,
    required int paymentAmount,
    @JsonKey(unknownEnumValue: RevolutCurrency.gbp)
    required RevolutCurrency currency,
    CustomerData? customer,
  }) = _PromoBannerParamsData;
  factory PromoBannerParamsData.fromJson(Map<String, dynamic> json) =>
      _$PromoBannerParamsDataFromJson(json);
  factory PromoBannerParamsData.fromMap(Map<String, dynamic> map) =>
      PromoBannerParamsData.fromJson(map);
  Map<String, dynamic> toMap() => toJson();
}

@freezed
abstract class OrderResultData with _$OrderResultData {
  const OrderResultData._();
  const factory OrderResultData({
    required bool success,
    String? orderId,
    String? error,
    String? cause,
  }) = _OrderResultData;
  factory OrderResultData.fromJson(Map<String, dynamic> json) =>
      _$OrderResultDataFromJson(json);
  factory OrderResultData.fromMap(Map<String, dynamic> map) =>
      OrderResultData.fromJson(map);
  Map<String, dynamic> toMap() => toJson();
}
