/// Configuration for the Revolut Pay button
class RevolutPayButtonConfigIos {
  final String orderToken;
  final int amount;
  final String currency;
  final String email;
  final bool shouldRequestShipping;
  final bool savePaymentMethodForMerchant;
  final String? returnURL;
  final String? merchantName;
  final String? merchantLogoURL;
  final Map<String, dynamic>? additionalData;

  const RevolutPayButtonConfigIos({
    required this.orderToken,
    required this.amount,
    required this.currency,
    required this.email,
    this.shouldRequestShipping = false,
    this.savePaymentMethodForMerchant = false,
    this.returnURL,
    this.merchantName,
    this.merchantLogoURL,
    this.additionalData,
  });

  Map<String, dynamic> toMap() {
    return {
      'orderToken': orderToken,
      'amount': amount,
      'currency': currency,
      'email': email,
      'shouldRequestShipping': shouldRequestShipping,
      'savePaymentMethodForMerchant': savePaymentMethodForMerchant,
      'returnURL': returnURL,
      'merchantName': merchantName,
      'merchantLogoURL': merchantLogoURL,
      'additionalData': additionalData,
    };
  }
}
