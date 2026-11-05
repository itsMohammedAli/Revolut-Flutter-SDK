// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'revolut_pay_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CustomerData _$CustomerDataFromJson(Map<String, dynamic> json) =>
    _CustomerData(
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      dateOfBirth: json['dateOfBirth'] == null
          ? null
          : DateOfBirthData.fromJson(
              json['dateOfBirth'] as Map<String, dynamic>,
            ),
      country: json['country'] as String?,
    );

Map<String, dynamic> _$CustomerDataToJson(_CustomerData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'dateOfBirth': instance.dateOfBirth?.toJson(),
      'country': instance.country,
    };

_DateOfBirthData _$DateOfBirthDataFromJson(Map<String, dynamic> json) =>
    _DateOfBirthData(
      day: (json['day'] as num).toInt(),
      month: (json['month'] as num).toInt(),
      year: (json['year'] as num).toInt(),
    );

Map<String, dynamic> _$DateOfBirthDataToJson(_DateOfBirthData instance) =>
    <String, dynamic>{
      'day': instance.day,
      'month': instance.month,
      'year': instance.year,
    };

_ButtonParamsData _$ButtonParamsDataFromJson(Map<String, dynamic> json) =>
    _ButtonParamsData(
      radius:
          $enumDecodeNullable(
            _$ButtonRadiusEnumMap,
            json['radius'],
            unknownValue: ButtonRadius.medium,
          ) ??
          ButtonRadius.medium,
      size:
          $enumDecodeNullable(
            _$ButtonSizeEnumMap,
            json['size'],
            unknownValue: ButtonSize.large,
          ) ??
          ButtonSize.large,
      boxText:
          $enumDecodeNullable(
            _$BoxTextEnumMap,
            json['boxText'],
            unknownValue: BoxText.none,
          ) ??
          BoxText.none,
      boxTextCurrency: json['boxTextCurrency'] as String?,
      variantModes: json['variantModes'] == null
          ? null
          : VariantModesData.fromJson(
              json['variantModes'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$ButtonParamsDataToJson(_ButtonParamsData instance) =>
    <String, dynamic>{
      'radius': _$ButtonRadiusEnumMap[instance.radius]!,
      'size': _$ButtonSizeEnumMap[instance.size]!,
      'boxText': _$BoxTextEnumMap[instance.boxText]!,
      'boxTextCurrency': instance.boxTextCurrency,
      'variantModes': instance.variantModes?.toJson(),
    };

const _$ButtonRadiusEnumMap = {
  ButtonRadius.none: 'NONE',
  ButtonRadius.small: 'SMALL',
  ButtonRadius.medium: 'MEDIUM',
  ButtonRadius.large: 'LARGE',
};

const _$ButtonSizeEnumMap = {
  ButtonSize.extraSmall: 'EXTRA_SMALL',
  ButtonSize.small: 'SMALL',
  ButtonSize.medium: 'MEDIUM',
  ButtonSize.large: 'LARGE',
};

const _$BoxTextEnumMap = {
  BoxText.none: 'NONE',
  BoxText.getCashbackValue: 'GET_CASHBACK_VALUE',
  BoxText.getCashbackPercentage: 'GET_CASHBACK_PERCENTAGE',
};

_VariantModesData _$VariantModesDataFromJson(Map<String, dynamic> json) =>
    _VariantModesData(
      darkTheme:
          $enumDecodeNullable(
            _$ButtonVariantEnumMap,
            json['darkTheme'],
            unknownValue: ButtonVariant.dark,
          ) ??
          ButtonVariant.dark,
      lightTheme:
          $enumDecodeNullable(
            _$ButtonVariantEnumMap,
            json['lightTheme'],
            unknownValue: ButtonVariant.light,
          ) ??
          ButtonVariant.light,
    );

Map<String, dynamic> _$VariantModesDataToJson(_VariantModesData instance) =>
    <String, dynamic>{
      'darkTheme': _$ButtonVariantEnumMap[instance.darkTheme]!,
      'lightTheme': _$ButtonVariantEnumMap[instance.lightTheme]!,
    };

const _$ButtonVariantEnumMap = {
  ButtonVariant.light: 'LIGHT',
  ButtonVariant.dark: 'DARK',
};

_PromoBannerParamsData _$PromoBannerParamsDataFromJson(
  Map<String, dynamic> json,
) => _PromoBannerParamsData(
  transactionId: json['transactionId'] as String,
  paymentAmount: (json['paymentAmount'] as num).toInt(),
  currency: $enumDecode(
    _$RevolutCurrencyEnumMap,
    json['currency'],
    unknownValue: RevolutCurrency.gbp,
  ),
  customer: json['customer'] == null
      ? null
      : CustomerData.fromJson(json['customer'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PromoBannerParamsDataToJson(
  _PromoBannerParamsData instance,
) => <String, dynamic>{
  'transactionId': instance.transactionId,
  'paymentAmount': instance.paymentAmount,
  'currency': _$RevolutCurrencyEnumMap[instance.currency]!,
  'customer': instance.customer?.toJson(),
};

const _$RevolutCurrencyEnumMap = {
  RevolutCurrency.gbp: 'GBP',
  RevolutCurrency.eur: 'EUR',
  RevolutCurrency.usd: 'USD',
};

_OrderResultData _$OrderResultDataFromJson(Map<String, dynamic> json) =>
    _OrderResultData(
      success: json['success'] as bool,
      orderId: json['orderId'] as String?,
      error: json['error'] as String?,
      cause: json['cause'] as String?,
    );

Map<String, dynamic> _$OrderResultDataToJson(_OrderResultData instance) =>
    <String, dynamic>{
      'success': instance.success,
      'orderId': instance.orderId,
      'error': instance.error,
      'cause': instance.cause,
    };
