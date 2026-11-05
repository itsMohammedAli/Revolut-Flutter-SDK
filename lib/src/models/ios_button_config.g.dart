// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ios_button_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RevolutPayButtonConfigIos _$RevolutPayButtonConfigIosFromJson(
  Map<String, dynamic> json,
) => _RevolutPayButtonConfigIos(
  orderToken: json['orderToken'] as String,
  amount: (json['amount'] as num).toInt(),
  currency: json['currency'] as String,
  email: json['email'] as String,
  shouldRequestShipping: json['shouldRequestShipping'] as bool? ?? false,
  savePaymentMethodForMerchant:
      json['savePaymentMethodForMerchant'] as bool? ?? false,
  returnURL: json['returnURL'] as String?,
  merchantName: json['merchantName'] as String?,
  merchantLogoURL: json['merchantLogoURL'] as String?,
  additionalData: json['additionalData'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$RevolutPayButtonConfigIosToJson(
  _RevolutPayButtonConfigIos instance,
) => <String, dynamic>{
  'orderToken': instance.orderToken,
  'amount': instance.amount,
  'currency': instance.currency,
  'email': instance.email,
  'shouldRequestShipping': instance.shouldRequestShipping,
  'savePaymentMethodForMerchant': instance.savePaymentMethodForMerchant,
  'returnURL': instance.returnURL,
  'merchantName': instance.merchantName,
  'merchantLogoURL': instance.merchantLogoURL,
  'additionalData': instance.additionalData,
};
