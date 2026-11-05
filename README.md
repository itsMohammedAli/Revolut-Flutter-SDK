# revolut_sdk_bridge

A Flutter plugin for accepting Revolut Pay payments through the native Android
and iOS SDKs. The bridge uses Pigeon for typed native communication and Freezed
for immutable Dart data models.

## Supported features

| Public API | Android | iOS |
| --- | :---: | :---: |
| `CrossPlatformRevolutPayButton` | ✅ | ✅ |
| `RevolutSdkBridge.processPayment()` for custom buttons | ✅ | ✅ |
| `CrossPlatformRevolutPayPromoBanner` | ✅ | — |
| Payment result callbacks | ✅ | ✅ |
| Diagnostic log callbacks, debug builds only | ✅ | ✅ |

Orders are created on your backend. Pass the resulting order token to the plugin;
the plugin does not create orders or require your merchant secret key.

## Requirements

- Flutter **3.41.0+**, Dart **3.9.0+**, as declared in `pubspec.yaml`.
- Android **9+** (`minSdk = 28`) with a `FlutterFragmentActivity` host.
- iOS **15+**.
- Native SDKs: Android Revolut Pay Lite **3.4.0**, iOS Revolut Pay **3.18.0**.
- A merchant public key and an order token for the selected environment.

For repository development and code generation, use Dart **3.13+** with the
pinned generator dependencies. Use **JDK 17** for the example's Gradle build.
Android implementation code is Kotlin; iOS implementation code is Swift.

## Installation

Add the Git dependency and pin `ref` to a tag or commit containing this API:

```yaml
dependencies:
  revolut_sdk_bridge:
    git:
      url: https://github.com/itsMohammedAli/Revolut-Flutter-SDK.git
      ref: <tag-or-commit>
```

Run `flutter pub get`. Application consumers use the committed generated code
and do not need to run Pigeon or Freezed generators.

Import the package through its single public entry point:

```dart
import 'package:revolut_sdk_bridge/revolut_sdk_bridge.dart';
```

## Platform setup

### Android setup

1. **`MainActivity` must extend `FlutterFragmentActivity`.** The Revolut SDK requires a
   `ComponentActivity` host; a plain `FlutterActivity` does not satisfy that native requirement.

   ```kotlin
   // android/app/src/main/kotlin/.../MainActivity.kt
   import io.flutter.embedding.android.FlutterFragmentActivity

   class MainActivity : FlutterFragmentActivity()
   ```

2. **Declare your return-URL deep link** in `android/app/src/main/AndroidManifest.xml`
   (the scheme must match the `returnURL` you pass to the plugin; the default is
   `revolut-sdk-bridge://revolut-pay`):

   ```xml
   <activity android:name=".MainActivity" android:launchMode="singleTop" ...>
       <intent-filter>
           <action android:name="android.intent.action.VIEW" />
           <category android:name="android.intent.category.DEFAULT" />
           <category android:name="android.intent.category.BROWSABLE" />
           <data android:scheme="revolut-sdk-bridge" android:host="revolut-pay" />
       </intent-filter>
   </activity>
   ```

   The plugin already bundles the `INTERNET` permission and the
   `<queries><package android:name="com.revolut.revolut"/></queries>` entry, so you do
   **not** need `QUERY_ALL_PACKAGES` (a Play Store restricted permission).

Some native dependencies include the same OSGi manifest. If your
app reports a duplicate Java resource, add this inside `android {}` in your app's
`build.gradle.kts` (as in the example):

```kotlin
packaging {
    resources.excludes += "META-INF/versions/9/OSGI-INF/MANIFEST.MF"
}
```

### iOS setup

The plugin supports Swift Package Manager and CocoaPods. Both integrations use
Revolut Pay SDK 3.18.0 and require iOS 15+. Enable SwiftPM in the host app to use
the bundled Swift package:

```yaml
flutter:
  config:
    enable-swift-package-manager: true
```

For CocoaPods, run `pod install` in the app's `ios` directory after updating the
plugin or changing native source layout. Rebuild the app after native changes.

Add your return-URL scheme and the Revolut query schemes to `ios/Runner/Info.plist`:

```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleURLName</key><string>revolut-sdk-bridge</string>
        <key>CFBundleURLSchemes</key><array><string>revolut-sdk-bridge</string></array>
    </dict>
</array>
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>revolut</string>
    <string>revolutpay</string>
    <string>revolut-pay</string>
</array>
```

For the iOS Native SDK, register your App ID with Revolut and enable the
`webcredentials:revolut.com` Associated Domain for biometrics and passkeys, as
explained in [Revolut's iOS setup guide](https://developer.revolut.com/docs/guides/merchant/accept-payments/online-payments/revolut-pay/mobile/ios).

## Usage

### Initialize

```dart
final sdk = RevolutSdkBridge();

await sdk.initialize(
  merchantPublicKey: 'your_public_sandbox_key',
  environment: 'sandbox', // 'production' or 'main' for production
);
```

Use an order token from the same environment as the merchant public key.
Callbacks register automatically during initialization; no channel setup or
readiness polling is required.

### Display a payment button

```dart
CrossPlatformRevolutPayButton(
  orderToken: orderToken, // created by your backend
  amount: 1000, // minor units: 1000 = GBP 10.00
  currency: 'GBP',
  email: 'customer@example.com',
  returnURL: 'revolut-sdk-bridge://revolut-pay',
  onPaymentResult: (result) {
    // Update your application's payment state.
  },
  onPaymentCancelled: () {
    // Let the customer retry.
  },
  onPaymentError: (message) {
    // Display the payment error.
  },
  onError: (message) {
    // Handle button setup or other widget errors.
  },
);
```

The widget selects the native Android or iOS button and owns its payment listener.
Use widget callbacks for widget payments. The widget's result is a map; custom
button payments use the typed `RevolutPaymentResult` callback below.

### Use your own button

Register the result callback before starting a custom payment on either platform:

```dart
sdk.callbacks.onPaymentResult = (RevolutPaymentResult result) {
  if (result.success) {
    // Update the order state.
  } else if (result.error == 'user_abandoned_payment') {
    // Let the customer retry.
  } else {
    // Display result.error or result.message.
  }
};

final started = await sdk.processPayment(
  orderToken: orderToken,
  savePaymentMethodForMerchant: false,
);
```

`started` reports that the flow was initiated; the final outcome arrives through
`onPaymentResult`. Custom payments use the default return URL
`revolut-sdk-bridge://revolut-pay`, which must be registered in your app.
Android-specific order and lifecycle events are also available on `sdk.callbacks`.

### Display a promotional banner

Promotional banners are supported on Android and require customer details:

```dart
CrossPlatformRevolutPayPromoBanner(
  promoParams: const PromoBannerParamsData(
    transactionId: 'txn_123',
    paymentAmount: 1000,
    currency: RevolutCurrency.gbp,
    customer: CustomerData(
      email: 'customer@example.com',
      phone: '+440000000000',
      country: 'GB',
    ),
  ),
);
```

### Dispose callbacks

```dart
sdk.dispose();
```

Dispose the SDK's callbacks when their owner no longer needs them. Payment widgets
remove their own listeners when disposed. Initializing the SDK again registers
its callbacks again.

## Models

Data models use Freezed for immutable values, value equality, `copyWith`, and
JSON serialization:

```dart
const params = ButtonParamsData();
final smallButton = params.copyWith(size: ButtonSize.small);
final restored = ButtonParamsData.fromJson(smallButton.toJson());

assert(restored == smallButton);
```

`toMap` and `fromMap` delegate to the generated serializers. Native enum values
remain uppercase, nested models serialize into maps, and callback timestamps use
epoch milliseconds. SDK exceptions and Flutter widget styles remain ordinary
classes. Pigeon owns its separate transport models.

## Logging

**Plugin logging is debug-only.** Release builds do not print plugin diagnostics
or deliver `sdk.callbacks.onLog` events. Payment results and operational errors
remain available in release builds.

To observe diagnostic messages while debugging:

```dart
// debugPrint is available from package:flutter/foundation.dart.
sdk.callbacks.onLog = (RevolutLogEntry entry) {
  debugPrint(entry.toString());
};
```

Dart diagnostics use `kDebugMode`; Kotlin logging checks the debug build
configuration; Swift diagnostics use `#if DEBUG`. Application-owned logging is
controlled by your application.

## Diagnostics

```dart
final status = await sdk.getPluginStatus();
final platformVersion = await sdk.getPlatformVersion();
final nativeSdkVersion = await sdk.getSdkVersion();
final registered = sdk.callbacksRegistered;
```

`callbacksRegistered` describes local listener registration, not merchant key
validity or the outcome of a payment.

## Migrating to the simplified API

This refactor removes the old `android/`, `ios/`, and root bridge import paths,
MethodChannel aliases, platform-interface adapters, and manual event-channel
setup helpers. Use the single public import and the SDK/widget APIs above.
Manual controller operations and imperative button/banner creation methods have
been removed; use the widgets to render native UI.

Replace static iOS callback services with `sdk.callbacks.onPaymentResult` and
`sdk.callbacks.onLog`. Shared callback models are named `RevolutPaymentResult`,
`RevolutLogEntry`, and `RevolutLogLevel`.

After upgrading, rebuild the native app. CocoaPods users should run `pod install`
in the app's `ios` directory to refresh native source references.

## Development

### Run the example

For SwiftPM example builds, clone into a directory named `revolut_sdk_bridge`.
Flutter's local package override uses that directory name as the package identity.
This checkout requirement applies to this repository's example, not host apps.

```sh
git clone https://github.com/itsMohammedAli/Revolut-Flutter-SDK.git revolut_sdk_bridge
cd revolut_sdk_bridge
flutter pub get
cd example
flutter run --dart-define=REVOLUT_PUBLIC_KEY=your_public_sandbox_key
```

Optional defines: `REVOLUT_ENVIRONMENT` (defaults to `sandbox`) and
`REVOLUT_ORDER_ENDPOINT` (your backend endpoint). Keep merchant secret keys on
your backend.

### Generate code

```sh
# From the repository root:
flutter pub get
bash tool/generate_models.sh
bash tool/generate_pigeon.sh
```

- Edit Freezed model definitions under `lib/src/models/`. Commit their generated
  `.freezed.dart` and `.g.dart` files.
- Edit `pigeons/revolut_api.dart` for transport changes. Regenerate and commit the
  Dart, Kotlin, and Swift bindings together with the pinned Pigeon version.
- Do not edit generated files by hand. A full rebuild is required after native
  bridge changes; hot reload cannot replace native handlers.

### Verify changes

```sh
flutter analyze
flutter test
cd example
flutter test
flutter build apk --debug
flutter build ios --simulator --debug --no-codesign
```

CI checks generated files, analysis, tests, Android compilation, both iOS dependency
managers, and the Android release-logging regression test. Native payment flows
still need verification with a merchant sandbox key and a backend-created order.

### Repository layout

```text
lib/
  revolut_sdk_bridge.dart          # only public entry point
  src/
    api/                          # SDK facade
    models/                       # Freezed definitions, generated data models, errors
    callbacks/                    # callback container and event dispatch
    platform/                     # platform contract, adapter, callback transport
    widgets/                      # cross-platform and internal native-view widgets
    generated/                    # Pigeon Dart bindings
pigeons/                          # Pigeon source contract
tool/                             # generation scripts
android/src/main/kotlin/com/revolutpay/flutter/
  generated/                      # Pigeon Kotlin bindings
  views/                          # button and banner views
  support/                        # payment option parsing and debug logging
ios/revolut_sdk_bridge/Sources/revolut_sdk_bridge/
  Generated/                      # Pigeon Swift bindings
  Callbacks/                      # callbacks and debug log delivery
  Views/                          # native button and factory
  Support/                        # native helpers
```

See [architecture notes](doc/architecture.md) for module ownership and lifecycle
details.

## License

[MIT](LICENSE)
