import '../generated/revolut_api.g.dart';

extension PaymentResultMap on NativePaymentResult {
  Map<String, dynamic> toMap() => {
    'success': success,
    'message': message,
    'error': error,
    'timestamp': timestamp,
    if (viewId != null) 'viewId': viewId,
    if (orderToken != null) 'orderToken': orderToken,
  };
}

extension SdkInfoMap on SdkInfo {
  Map<String, dynamic> toMap() => {
    'version': version,
    'platform': platform,
    'buildNumber': buildNumber,
  };
}

extension ButtonCreatedMap on ButtonCreated {
  Map<String, dynamic> toMap() => {
    'buttonCreated': true,
    'viewId': viewId,
    'orderToken': request.orderToken,
    'amount': request.amount,
    'currency': request.currency,
    'email': request.email,
    'shouldRequestShipping': request.shouldRequestShipping,
    'savePaymentMethodForMerchant': request.savePaymentMethodForMerchant,
    'returnURL': request.returnURL ?? 'revolut-sdk-bridge://revolut-pay',
    'merchantName': request.merchantName ?? '',
    'merchantLogoURL': request.merchantLogoURL ?? '',
    'additionalData': request.additionalData ?? <String, Object?>{},
    'type': 'revolut_pay_button',
    'message': 'Revolut Pay button configuration created successfully',
  };
}
