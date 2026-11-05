## Unreleased

### Breaking cleanup

- Keep a single public entry point and remove legacy forwarding files and platform exports.
- Remove unsupported controller operations, unused models, and the platform-interface dependency.
- Register callbacks automatically and replace manual event-channel helpers with `callbacksRegistered`.
- Expose shared payment/log models and callbacks through `sdk.callbacks` on both platforms.

- Organize implementation into API, models, callbacks, platform, widgets, generated, and compatibility modules.
- Route the public facade through one shared platform contract.
- Split native view, callback, and support code and remove global native plugin singletons.

- Replace handwritten method/event channels with generated Pigeon APIs for Android and iOS.
- Add typed initialization, payment, button, SDK info, result, and log messages.
- Share callback routing and scope payment listeners by button ID.
- Reuse the facade's Android adapter and fix the recursive legacy platform interface accessor.

# Changelog

## Unreleased

- Remove obsolete setup guides, workaround scripts, standalone native scaffolding,
  editor settings, and a committed build report.
- Consolidate documentation and replace the stale example widget test with a demo
  smoke test; ignore generated build output at every directory level.

## 0.2.1

- Add iOS Swift Package Manager support using the official Revolut 3.18.0 package.
- Share Swift sources and the privacy manifest between SwiftPM and CocoaPods.

## 0.2.0

- Upgrade Android Revolut Pay Lite to 3.4.0 and iOS Revolut Pay to 3.18.0.
- Require iOS 15.0, Flutter 3.41.0 and Dart 3.9.0 or newer.
- Adapt Android button variants and preferred payment modes to the updated SDK API.
- Align example deployment targets and provide public configuration via dart-define.
- Forward payment return URLs through the Flutter scene lifecycle, including cold starts.
- Update Flutter lints and validate on current Flutter stable.

## 0.1.0

First public release of the Revolut Pay Flutter plugin. It wraps the native
Revolut Pay **Lite** SDK on Android and the Revolut Pay SDK on iOS.

### Added
- `RevolutPayButton` widget that renders the native Revolut Pay button and runs
  the real payment flow on both Android and iOS.
- `CrossPlatformRevolutPayButton` convenience widget that picks the right
  platform implementation automatically.
- One-shot `pay()` for custom (merchant-rendered) buttons on Android, backed by a
  real `RevolutPaymentController`.
- Native Revolut Pay promotional banner (`RevolutPayPromoBanner`) on Android.
- SDK initialization with `sandbox` / `production` environments.

### Changed
- Android plugin namespace is now `com.revolutpay.flutter`.
- Bumped the Android Revolut Pay Lite SDK to `3.2.0`.

### Fixed
- The widget loading state now renders a button-shaped skeleton instead of a
  lone spinner, and `CrossPlatformRevolutPayButton` accepts custom
  `loadingWidget` / `placeholderWidget`. A failed button creation shows an
  inert "Revolut Pay" placeholder instead of an endless spinner (iOS).
- The native button is released when the widget is disposed and recreated when
  the order token changes (previously a refreshed token kept paying with the
  stale one unless the widget happened to be remounted).
- iOS accepts the same environment aliases as Android
  (`production`/`prod`/`live`/`main`); previously anything but the exact string
  `production` silently fell back to sandbox.
- iOS button cleanup no longer leaks view instances and no longer reuses view
  ids, which could collide payment channel names of live buttons.
- Android method-channel responses are decoded correctly
  (`Map<Object?, Object?>` results never matched `Map<String, dynamic>` checks).
- Order tokens and merchant keys are masked in native logs, debug log noise is
  removed, and wire timestamps are milliseconds on both platforms.

### Notes
- The Revolut Pay Lite SDK has **no** manual confirmation-flow/controller API.
  The former `createController` / `setOrderToken` / `setSavePaymentMethodForMerchant`
  / `continueConfirmationFlow` / `disposeController` stubs used to return fake
  success; they now return an explicit `UNSUPPORTED` error. Use the
  `RevolutPayButton` widget, or `pay()` for a custom button.
- iOS is button/widget-only: use the `RevolutPayButton` widget. A headless
  `pay()` is not supported by the iOS SDK and returns an explicit error.
- Promotional banners are Android-only.
