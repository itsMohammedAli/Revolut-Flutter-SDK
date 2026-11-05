import 'dart:io';
import 'package:flutter/material.dart';
import '../models/revolut_pay_models.dart';
import 'android/revolut_pay_button.dart' as android;
import 'ios/revolut_pay_button.dart' as ios;

/// Cross-platform Revolut Pay button widget
/// Automatically adapts to the current platform
class CrossPlatformRevolutPayButton extends StatelessWidget {
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

  // Android-specific parameters
  final ButtonParamsData? buttonParams;
  final String? preferredMode;

  // iOS-specific parameters
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final Widget? loadingWidget;
  final Widget? placeholderWidget;

  // Callbacks
  final VoidCallback? onPressed;
  final Function(String)? onError;
  final Function(Map<String, dynamic>)? onPaymentResult;
  final Function(String)? onPaymentError;
  final VoidCallback? onPaymentCancelled;
  final VoidCallback? onButtonCreated;
  final VoidCallback? onButtonError;

  const CrossPlatformRevolutPayButton({
    super.key,
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
    this.buttonParams,
    this.preferredMode,
    this.height,
    this.width,
    this.margin,
    this.padding,
    this.borderRadius,
    this.loadingWidget,
    this.placeholderWidget,
    this.onPressed,
    this.onError,
    this.onPaymentResult,
    this.onPaymentError,
    this.onPaymentCancelled,
    this.onButtonCreated,
    this.onButtonError,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      // Use Android implementation
      return android.RevolutPayButton(
        buttonParams: buttonParams,
        orderToken: orderToken,
        amount: amount,
        currency: currency,
        email: email,
        shouldRequestShipping: shouldRequestShipping,
        savePaymentMethodForMerchant: savePaymentMethodForMerchant,
        returnURL: returnURL,
        merchantName: merchantName,
        merchantLogoURL: merchantLogoURL,
        additionalData: additionalData,
        preferredMode: preferredMode,
        onPressed: onPressed,
        onPaymentSuccess: onPaymentResult,
        onPaymentError: (error, details) => onPaymentError?.call(error),
        onPaymentCancelled: onPaymentCancelled,
        onError: onError,
        width: width,
        height: height,
        margin: margin,
        padding: padding,
        decoration: borderRadius != null
            ? BoxDecoration(borderRadius: borderRadius)
            : null,
      );
    } else if (Platform.isIOS) {
      // Use iOS implementation
      return ios.RevolutPayButtonIos(
        config: ios.RevolutPayButtonConfigIos(
          orderToken: orderToken,
          amount: amount,
          currency: currency,
          email: email,
          shouldRequestShipping: shouldRequestShipping,
          savePaymentMethodForMerchant: savePaymentMethodForMerchant,
          returnURL: returnURL,
          merchantName: merchantName,
          merchantLogoURL: merchantLogoURL,
          additionalData: additionalData,
        ),
        style: ios.RevolutPayButtonStyleIos(
          height: height,
          width: width,
          margin: margin,
          padding: padding,
          borderRadius: borderRadius,
        ),
        loadingWidget: loadingWidget,
        placeholderWidget: placeholderWidget,
        onPaymentResult: onPaymentResult != null
            ? (result) => onPaymentResult!({
                'success': result.success,
                'message': result.message,
                'error': result.error,
                'timestamp': result.timestamp.toIso8601String(),
              })
            : null,
        onPaymentError: onPaymentError,
        onPaymentCancelled: onPaymentCancelled,
        onButtonCreated: onButtonCreated,
        onButtonError: onButtonError,
        onError: onError,
      );
    } else {
      // Fallback for unsupported platforms
      return Container(
        height: height ?? 50,
        width: width,
        margin: margin,
        padding: padding ?? const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: borderRadius ?? BorderRadius.circular(8),
        ),
        child: const Center(
          child: Text(
            'Revolut Pay Button\n(Platform not supported)',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12),
          ),
        ),
      );
    }
  }
}
