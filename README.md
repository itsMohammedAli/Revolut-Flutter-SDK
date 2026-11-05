# revolut_sdk_bridge

A Flutter plugin for accepting **Revolut Pay** payments using the native Revolut Pay
SDKs — the **Revolut Pay Lite SDK** on Android and the **Revolut Pay SDK** on iOS.

> Status: early release (`0.2.1`). The native payment flows must be verified against a
> real Revolut **merchant sandbox key** on a device/simulator — see
> [Sandbox testing](#sandbox-testing). This plugin wraps native SDKs that cannot run in
> CI, so always test the real flow before shipping.

## What's supported

| Feature | Android | iOS |
| --- | :---: | :---: |
| `RevolutPayButton` widget (native button + real payment) | ✅ | ✅ |
| `CrossPlatformRevolutPayButton` widget | ✅ | ✅ |
| One-shot `pay()` for your own custom button | ✅ | ❌ (button-only SDK) |
| Promotional banner (`RevolutPayPromoBanner`) | ✅ | ❌ (Android only) |
| Manual "confirmation flow" / payment controllers | ❌ (not in the SDK) | ❌ |

The Revolut Pay **Lite** SDK (Android) and the iOS SDK do **not** expose a manual
confirmation-flow/controller API. The former `createController` / `setOrderToken` /
`continueConfirmationFlow` / `disposeController` methods now return an explicit
`UNSUPPORTED` error instead of a fake success. Use the widget, or `pay()` on Android.

## Requirements

- **Android:** `minSdkVersion` **28** (Android 9). Your `MainActivity` **must** extend
  `FlutterFragmentActivity` (see below).
- **iOS:** **15.0+**.
- **Flutter:** **3.41.0+**, Dart **3.9.0+**.
- Native SDK versions: Android Revolut Pay Lite **3.4.0**, iOS Revolut Pay **3.18.0**.
- A Revolut **merchant public key** (sandbox or production) from the
  [Revolut Merchant Dashboard](https://merchant.revolut.com/).
- An **order token** created server-side via the Revolut Merchant API. The plugin never
  creates orders — your backend does, and you pass the resulting `orderToken` in.

## Installation

```yaml
dependencies:
  revolut_sdk_bridge:
    git:
      url: https://github.com/itsMohammedAli/Revolut-Flutter-SDK.git
      ref: feat/upgrade-native-sdks
```

### Android setup

1. **`MainActivity` must extend `FlutterFragmentActivity`.** The Revolut SDK requires a
   `ComponentActivity` host; a plain `FlutterActivity` will not work and payments will
   silently fail.

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

The updated SDK pulls in libraries that both include an OSGi manifest. If your
app reports a duplicate Java resource, add this inside `android {}` in your app's
`build.gradle.kts` (as in the example):

```kotlin
packaging {
    resources.excludes += "META-INF/versions/9/OSGI-INF/MANIFEST.MF"
}
```

### iOS setup

The plugin supports Swift Package Manager and CocoaPods. Flutter selects SwiftPM
when it is enabled in the host app (Flutter 3.44+); no manual Xcode package installation is needed.
Both integrations use the official Revolut Pay SDK 3.18.0 and require iOS 15+.

To enable SwiftPM for your app, add this under `flutter:` in its `pubspec.yaml`:

```yaml
flutter:
  config:
    enable-swift-package-manager: true
```

After updating the Git dependency, run `flutter pub get` and rebuild the iOS app.


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

### 1. Initialize the SDK

```dart
import 'package:revolut_sdk_bridge/revolut_sdk_bridge.dart';

await RevolutSdkBridge().initialize(
  merchantPublicKey: 'pk_XXXXXXXX', // sandbox or production key
  environment: 'sandbox',           // or 'production' / 'main'
);
```

### 2. Show the Revolut Pay button (recommended)

Create the order on your backend, get the `orderToken`, then render the button:

```dart
CrossPlatformRevolutPayButton(
  orderToken: orderToken,   // from your server
  amount: 1000,             // minor units, e.g. 1000 = £10.00
  currency: 'GBP',
  email: 'customer@example.com',
  returnURL: 'revolut-sdk-bridge://revolut-pay',
  onPaymentResult: (result) => debugPrint('Paid: $result'),
  onPaymentCancelled: () => debugPrint('Cancelled'),
  onError: (error) => debugPrint('Error: $error'),
);
```

### 3. One-shot `pay()` with your own button (Android only)

```dart
// Android only. On iOS this throws (the iOS SDK is button-only — use the widget).
await RevolutSdkBridge().processPayment(
  orderToken: orderToken,
  savePaymentMethodForMerchant: false,
);
// The result arrives via the event channel (onOrderCompleted / onOrderFailed /
// onUserPaymentAbandoned) — see RevolutCallbacks.
```

### 4. Promotional banner (Android only)

The banner **requires** customer details (email, phone, country):

```dart
CrossPlatformRevolutPayPromoBanner(
  promoParams: PromoBannerParamsData(
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

## Sandbox testing

1. Get a **sandbox** merchant key from the Revolut Merchant Dashboard.
2. Create an order server-side (Merchant API) and pass its `orderToken` to the widget.
3. Run on a real device or simulator and complete a payment.
4. The sandbox replicates production **except** there is no app redirect (there is no
   sandbox build of the Revolut retail app).

## License

[MIT](LICENSE)

## Upgrading from 0.1.0

Raise your iOS deployment target to 15.0 in the Podfile and Xcode project, then
run `pod update RevolutPayments` inside your iOS directory. Android requires
`minSdk = 28`, matching the existing integration branch.

Use Java 17 for the example Android build (AGP 8.11.1, Gradle 8.14.3, Kotlin 2.2.21).
The plugin forwards iOS payment returns through both AppDelegate and UIScene callbacks.

The example uses public configuration passed at launch:

```sh
cd example
flutter run --dart-define=REVOLUT_PUBLIC_KEY=your_public_sandbox_key
```

Optional defines: `REVOLUT_ENVIRONMENT` (defaults to `sandbox`) and
`REVOLUT_ORDER_ENDPOINT` (your backend endpoint). Never pass a merchant secret key.

Native releases were checked against
[Maven Central](https://repo.maven.apache.org/maven2/com/revolut/payments/revolutpaylite/maven-metadata.xml)
and the [CocoaPods spec](https://trunk.cocoapods.org/api/v1/pods/RevolutPayments/specs/3.18.0).
