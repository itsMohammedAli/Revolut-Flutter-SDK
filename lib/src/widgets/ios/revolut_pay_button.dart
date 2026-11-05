import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../generated/revolut_api.g.dart';
import '../../models/ios_button_config.dart';
import '../../models/ios_callback_models.dart';
import '../../platform/legacy_converters.dart';
import '../../platform/native_button_controller.dart';
import '../../platform/revolut_transport.dart';

export '../../models/ios_button_config.dart';

/// The Revolut Pay button widget
class RevolutPayButtonIos extends StatefulWidget {
  final RevolutPayButtonConfigIos config;
  final RevolutPayButtonStyleIos? style;
  final Widget? loadingWidget;
  final Widget? placeholderWidget;
  final Function(RevolutPaymentResultIos)? onPaymentResult;
  final Function(String)? onPaymentError;
  final VoidCallback? onPaymentCancelled;
  final VoidCallback? onButtonCreated;
  final VoidCallback? onButtonError;
  final Function(String)? onError; // Simple error callback

  const RevolutPayButtonIos({
    super.key,
    required this.config,
    this.style,
    this.loadingWidget,
    this.placeholderWidget,
    this.onPaymentResult,
    this.onPaymentError,
    this.onPaymentCancelled,
    this.onButtonCreated,
    this.onButtonError,
    this.onError,
  });

  @override
  State<RevolutPayButtonIos> createState() => _RevolutPayButtonIosState();
}

/// Style configuration for the Revolut Pay button
class RevolutPayButtonStyleIos {
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final BoxBorder? border;
  final List<BoxShadow>? boxShadow;
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;

  const RevolutPayButtonStyleIos({
    this.height,
    this.width,
    this.margin,
    this.padding,
    this.borderRadius,
    this.border,
    this.boxShadow,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.fontFamily,
  });

  Map<String, dynamic> toMap() {
    return {
      'height': height,
      'width': width,
      'margin': margin?.toString(),
      'padding': padding?.toString(),
      'borderRadius': borderRadius?.toString(),
      'border': border?.toString(),
      'boxShadow': boxShadow?.map((shadow) => shadow.toString()).toList(),
      'backgroundColor': backgroundColor?.toARGB32(),
      'textColor': textColor?.toARGB32(),
      'fontSize': fontSize,
      'fontWeight': fontWeight?.value,
      'fontFamily': fontFamily,
    };
  }
}

class _RevolutPayButtonIosState extends State<RevolutPayButtonIos> {
  final NativeButtonController _buttons = NativeButtonController();
  Map<String, dynamic>? _buttonConfig;
  bool _isLoading = true;
  int? _nativeButtonId;

  @override
  void initState() {
    super.initState();
    _createButton();
  }

  @override
  void didUpdateWidget(RevolutPayButtonIos oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.config.orderToken != widget.config.orderToken) {
      _recreateButton();
    }
  }

  @override
  void dispose() {
    if (_nativeButtonId != null) {
      RevolutTransport.instance.removeButtonListener(_nativeButtonId!);
    }
    _releaseNativeButton();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return widget.loadingWidget ?? _buildDefaultLoading();
    }
    if (_buttonConfig == null) {
      return widget.placeholderWidget ?? _buildDefaultPlaceholder();
    }
    return _buildIOSButton();
  }

  void _releaseNativeButton() {
    final buttonId = _nativeButtonId;
    _nativeButtonId = null;
    if (buttonId != null) {
      _buttons.cleanup(buttonId).catchError((_) => false);
    }
  }

  Future<void> _recreateButton() async {
    if (_nativeButtonId != null) {
      RevolutTransport.instance.removeButtonListener(_nativeButtonId!);
    }
    _releaseNativeButton();
    setState(() {
      _buttonConfig = null;
      _isLoading = true;
    });
    await _createButton();
  }

  Future<void> _createButton() async {
    try {
      setState(() => _isLoading = true);

      final result = (await _buttons.create(
        ButtonRequest(
          orderToken: widget.config.orderToken,
          amount: widget.config.amount,
          currency: widget.config.currency,
          email: widget.config.email,
          shouldRequestShipping: widget.config.shouldRequestShipping,
          savePaymentMethodForMerchant:
              widget.config.savePaymentMethodForMerchant,
          returnURL: widget.config.returnURL,
          merchantName: widget.config.merchantName,
          merchantLogoURL: widget.config.merchantLogoURL,
          additionalData: widget.config.additionalData,
        ),
      )).toMap();

      if (!mounted) {
        final viewId = result['viewId'];
        if (result['buttonCreated'] == true && viewId is int) {
          _buttons.cleanup(viewId).catchError((_) => false);
        }
        return;
      }

      if (result['buttonCreated'] == true) {
        final viewId = result['viewId'];
        _nativeButtonId = viewId is int ? viewId : null;
        if (_nativeButtonId != null) {
          RevolutTransport.instance.addButtonListener(
            _nativeButtonId!,
            _handleNativePaymentResult,
          );
        }

        setState(() {
          _buttonConfig = result;
          _isLoading = false;
        });
        widget.onButtonCreated?.call();
      } else {
        throw Exception(
          'Failed to create button: ${result['message'] ?? 'Unknown error'}',
        );
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      widget.onError?.call(e.toString());
      widget.onButtonError?.call();
    }
  }

  void _handleNativePaymentResult(NativePaymentResult result) {
    if (mounted) _handlePaymentResult(result.toMap());
  }

  void _handlePaymentResult(Map<String, dynamic> resultData) {
    final success = resultData['success'] as bool? ?? false;
    final message = resultData['message'] as String? ?? '';
    final error = resultData['error'] as String? ?? '';

    if (success) {
      widget.onPaymentResult?.call(
        RevolutPaymentResultIos(
          success: true,
          message: message,
          error: '',
          timestamp: DateTime.now(),
        ),
      );
      return;
    }

    final lowerMessage = message.toLowerCase();
    if (error == 'user_abandoned_payment' ||
        lowerMessage.contains('abandoned') ||
        lowerMessage.contains('cancelled')) {
      widget.onPaymentCancelled?.call();
    } else {
      final failure = error.isNotEmpty ? error : 'Payment failed';
      widget.onError?.call(failure);
      widget.onPaymentError?.call(failure);
    }
  }

  Widget _buildIOSButton() {
    final creationParams = {
      ..._buttonConfig!,
      'buttonId': _buttonConfig!['viewId'],
      'style': widget.style?.toMap(),
    };

    return Container(
      height: widget.style?.height ?? 50,
      width: widget.style?.width,
      margin: widget.style?.margin,
      child: UiKitView(
        key: ValueKey(_buttonConfig!['viewId']),
        viewType: 'revolut_pay_button',
        creationParams: creationParams,
        creationParamsCodec: const StandardMessageCodec(),
      ),
    );
  }

  /// Skeleton matching the size and shape of the final native button, so the
  /// loading and unavailable states don't render as a lone spinner.
  Widget _buildButtonShell({required Widget child}) {
    return Container(
      height: widget.style?.height ?? 50,
      width: widget.style?.width ?? double.infinity,
      margin: widget.style?.margin,
      decoration: BoxDecoration(
        color: widget.style?.backgroundColor ?? Colors.black,
        borderRadius: widget.style?.borderRadius ?? BorderRadius.circular(12),
        border: widget.style?.border,
        boxShadow: widget.style?.boxShadow,
      ),
      child: child,
    );
  }

  Widget _buildDefaultLoading() {
    return _buildButtonShell(
      child: Center(
        child: SizedBox(
          width: 22,
          height: 22,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(
              widget.style?.textColor ?? Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDefaultPlaceholder() {
    return Opacity(
      opacity: 0.45,
      child: _buildButtonShell(
        child: Center(
          child: Text(
            'Revolut Pay',
            style: TextStyle(
              color: widget.style?.textColor ?? Colors.white,
              fontSize: widget.style?.fontSize ?? 16,
              fontWeight: widget.style?.fontWeight ?? FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
