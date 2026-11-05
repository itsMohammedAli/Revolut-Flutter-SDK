import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/revolut_pay_models.dart';

class RevolutPayPromoBanner extends StatefulWidget {
  /// Promotional banner parameters
  final PromoBannerParamsData? promoParams;

  /// Theme ID for the banner
  final String? themeId;

  /// Callback when banner is interacted with
  final Function(String bannerId, String interactionType)? onInteraction;

  /// Callback when banner creation fails
  final Function(String error)? onError;

  /// Width of the banner
  final double? width;

  /// Height of the banner
  final double? height;

  const RevolutPayPromoBanner({
    super.key,
    this.promoParams,
    this.themeId,
    this.onInteraction,
    this.onError,
    this.width,
    this.height,
  });

  @override
  State<RevolutPayPromoBanner> createState() => _RevolutPayPromoBannerState();
}

class _RevolutPayPromoBannerState extends State<RevolutPayPromoBanner> {
  static const String _viewType = 'revolut_pay_promo_banner';

  @override
  Widget build(BuildContext context) {
    if (widget.promoParams == null) {
      return _buildErrorState('Missing promoParams');
    }

    final creationParams = <String, dynamic>{
      'promoParams': widget.promoParams!.toMap(),
      'themeId': widget.themeId,
    };

    return SizedBox(
      width: widget.width ?? double.infinity,
      height: widget.height ?? 80.0, // Estimated height for banner
      child: AndroidView(
        viewType: _viewType,
        creationParams: creationParams,
        creationParamsCodec: const StandardMessageCodec(),
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Container(
      width: widget.width,
      height: widget.height ?? 80.0,
      decoration: BoxDecoration(
        color: Colors.orange[100],
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.orange),
      ),
      child: Center(
        child: Text(
          message,
          style: TextStyle(color: Colors.orange[800], fontSize: 12.0),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
