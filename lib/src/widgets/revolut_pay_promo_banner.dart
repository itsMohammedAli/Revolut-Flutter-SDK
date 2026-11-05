import 'dart:io';
import 'package:flutter/material.dart';
import '../models/revolut_pay_models.dart';
import 'android/revolut_pay_promo_banner.dart' as android;

/// Cross-platform promotional banner widget (Android only)
class CrossPlatformRevolutPayPromoBanner extends StatelessWidget {
  final PromoBannerParamsData? promoParams;
  final String? themeId;
  final double? width;
  final double? height;
  final Function(String, String)? onInteraction;
  final Function(String)? onError;

  const CrossPlatformRevolutPayPromoBanner({
    super.key,
    this.promoParams,
    this.themeId,
    this.width,
    this.height,
    this.onInteraction,
    this.onError,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      // Use Android implementation
      return android.RevolutPayPromoBanner(
        promoParams: promoParams,
        themeId: themeId,
        width: width,
        height: height,
        onInteraction: onInteraction != null
            ? (bannerId, interactionType) =>
                  onInteraction!(bannerId, interactionType)
            : null,
        onError: onError,
      );
    } else {
      // iOS doesn't support promotional banners
      return Container(
        width: width,
        height: height ?? 80,
        decoration: BoxDecoration(
          color: Colors.orange[100],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.orange),
        ),
        child: const Center(
          child: Text(
            'Promotional Banners\n(Not supported on iOS)',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.orange,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      );
    }
  }
}
