# Architecture

The package is a layered Flutter plugin. The public SDK facade and widgets use a
shared Pigeon transport to call the native Revolut SDKs. Generated messages stay
inside the implementation boundary; public models and callback signatures remain
independent of the generated classes.

## Ownership

- `api/`: the public facade delegates SDK operations to `RevolutPlatform`. It does
  not import Android/iOS compatibility implementations or generated messages.
- `platform/`: `RevolutPlatform` defines the facade contract; the factory chooses
  the runtime platform, and `PigeonRevolutPlatform` implements the contract with
  the generated host API. `NativeButtonController` handles iOS view creation.
- `callbacks/`: services expose application callbacks; the event dispatcher maps
  extensible native events to those callbacks.
- `models/`: shared parameters, result data, enums, and SDK errors. Platform-specific
  iOS model names remain to preserve source compatibility.
- `widgets/`: cross-platform widgets choose a native view. Android button and
  banner widgets have separate state; iOS button configuration is a model.
- `generated/`: generated transport definitions only. Edit `pigeons/revolut_api.dart`
  and run `bash tool/generate_pigeon.sh` to update every language together.
- `compatibility/`: historical platform interfaces and adapters. Current code does
  not depend on these modules; old public import paths re-export their original
  types rather than defining duplicate copies.

## Lifecycles

The shared transport owns one native callback receiver per Flutter isolate. Each
SDK platform instance owns its Android event listener, registers it idempotently,
and removes it on disposal. Initialization can register it again. Each payment
widget owns its button listener and removes it when replaced or disposed. The
iOS widget also releases its native button.

Native plugin instances are scoped to a Flutter engine. iOS factories receive the
owning plugin explicitly through a weak reference; neither native platform uses a
global plugin singleton. The Kotlin plugin handles registration, Activity events,
and SDK operations. View code and payment option parsing live in separate files.
The Swift plugin handles registration, deep links, and SDK operations, while
callback delivery, view factories, views, and shared helpers have their own files.

## Compatibility and tests

The main entry point keeps the historical exports available. New code should use
`RevolutSdkBridge`, the cross-platform widgets, and shared public models. Legacy
controller methods still return the native SDK's `UNSUPPORTED` errors.

The facade can receive a platform implementation through its testing constructor;
the Pigeon adapter can receive a generated host API. Tests verify the real generated
codec, error envelopes, callback routing, disposal/reinitialization, unsupported
platforms, and legacy import paths. Native builds verify the split sources and
both iOS dependency managers. Real payment outcomes require merchant sandbox tests.
