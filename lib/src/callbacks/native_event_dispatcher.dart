import 'package:flutter/foundation.dart';
import '../generated/revolut_api.g.dart';
import 'revolut_callbacks.dart';

/// Converts extensible native events into the public callback API.
class NativeEventDispatcher {
  NativeEventDispatcher(this.callbacks);
  final RevolutCallbacks callbacks;

  void handleEvent(NativeEvent event) {
    final methodName = event.name;
    final data = Map<String, dynamic>.from(event.data);
    try {
      switch (methodName) {
        case 'onOrderCompleted':
          if (kDebugMode) debugPrint('🎉 ORDER COMPLETED: $data');
          callbacks.handleOrderCompleted(data);
          break;
        case 'onOrderFailed':
          if (kDebugMode) debugPrint('❌ ORDER FAILED: $data');
          callbacks.handleOrderFailed(data);
          break;
        case 'onUserPaymentAbandoned':
          if (kDebugMode) debugPrint('⚠️ USER ABANDONED PAYMENT: $data');
          callbacks.handleUserPaymentAbandoned(data);
          break;
        case 'onPaymentStatusUpdate':
          if (kDebugMode) debugPrint('📊 PAYMENT STATUS UPDATE: $data');
          callbacks.handlePaymentStatusUpdate(data);
          break;
        case 'onButtonClick':
          if (kDebugMode) debugPrint('🔵 BUTTON CLICKED: $data');
          callbacks.handleButtonClick(data);
          break;
        case 'onControllerStateChange':
          if (kDebugMode) debugPrint('🔄 CONTROLLER STATE CHANGE: $data');
          callbacks.handleControllerStateChange(data);
          break;
        case 'onBannerInteraction':
          callbacks.handleBannerInteraction(data);
          break;
        case 'onLifecycleEvent':
          callbacks.handleLifecycleEvent(data);
          break;
        case 'onDeepLinkReceived':
          if (kDebugMode) debugPrint('🔗 DEEP LINK RECEIVED: $data');
          callbacks.handleDeepLinkEvent(data);
          break;
        case 'onNetworkStatusUpdate':
          callbacks.handleNetworkStatusUpdate(data);
          break;
        case 'onConfigurationUpdate':
          callbacks.handleConfigurationUpdate(data);
          break;
        case 'onDebugLog':
          if (kDebugMode) callbacks.handleDebugLog(data);
          break;
        case 'onPerformanceMetric':
          callbacks.handlePerformanceMetric(data);
          break;
        case 'onUserInteraction':
          callbacks.handleUserInteraction(data);
          break;
        case 'onSessionEvent':
          callbacks.handleSessionEvent(data);
          break;
        default:
          if (kDebugMode) debugPrint('❓ Unknown event method: $methodName');
      }
    } catch (error, stack) {
      if (kDebugMode) {
        FlutterError.reportError(
          FlutterErrorDetails(
            exception: error,
            stack: stack,
            library: 'revolut_sdk_bridge',
            context: ErrorDescription('dispatching a native event'),
          ),
        );
      }
    }
  }
}
