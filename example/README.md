# Revolut Pay example

Run this app on Android or iOS to exercise SDK initialization, native payment
buttons, callbacks, and plugin diagnostics.

Clone the repository into a directory named `revolut_sdk_bridge` for SwiftPM
example builds, then run:

```sh
cd revolut_sdk_bridge/example
flutter pub get
flutter run --dart-define=REVOLUT_PUBLIC_KEY=your_public_sandbox_key
```

Use a public sandbox key only. Create payment orders on your backend; replace
the demo order token with a valid sandbox order token to exercise payment flows.
The configuration supports `REVOLUT_ENVIRONMENT` and `REVOLUT_ORDER_ENDPOINT`.

See the [main README](../README.md) for requirements, platform setup, SwiftPM and
CocoaPods integration, and payment examples.

Run the example's widget test with `flutter test` from this directory.
