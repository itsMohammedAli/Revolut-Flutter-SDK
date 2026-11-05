# Architecture

The package is a layered Flutter plugin. The public SDK facade and widgets use a
shared Pigeon transport to call the native Revolut SDKs. Generated messages stay
inside the implementation boundary; public models and callback signatures remain
independent of the generated classes.

## Ownership

- `api/`: the public facade delegates SDK operations to `RevolutPlatform`. It does
  not import platform-specific implementations or generated messages.
- `platform/`: `RevolutPlatform` defines the facade contract; the factory chooses
  the runtime platform, and `PigeonRevolutPlatform` implements the contract with
  the generated host API. `NativeButtonController` handles iOS view creation.
- `callbacks/`: services expose application callbacks; the event dispatcher maps
  extensible native events to those callbacks.
- `models/`: Freezed parameters, payment results, and log entries, plus enums and SDK errors.
  Configuration used only by the internal iOS native view stays internal.
- `widgets/`: cross-platform widgets choose a native view. Android button and
  banner widgets have separate state; iOS button configuration is a model.
- `generated/`: generated transport definitions only. Edit `pigeons/revolut_api.dart`
  and run `bash tool/generate_pigeon.sh` to update every language together.

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

## Public API and tests

`lib/revolut_sdk_bridge.dart` is the only public entry point. It exports the SDK
facade, cross-platform widgets, shared models, callback container, and SDK errors.
There are no legacy barrels, MethodChannel aliases, forwarding files, or exported
platform adapters. Unsupported controller APIs and their data types are removed
from Dart, Pigeon, Kotlin, and Swift.

Application callbacks belong to the SDK instance; disposing it unregisters its
payment, log, and Android event listeners without removing widget listeners.

The facade can receive a platform implementation through its testing constructor;
the Pigeon adapter can receive a generated host API. Tests verify the generated
codec, error envelopes, callback routing, disposal/reinitialization, and unsupported
platforms. Native builds verify both iOS dependency managers and Android compilation.
Real payment outcomes require merchant sandbox tests.

## Model generation

Freezed and json_serializable generate the data models. The custom timestamp
converter and enum annotations preserve native wire formats. Nested models are
serialized explicitly into maps before platform-view creation. Run
`bash tool/generate_models.sh` after editing model definitions; commit generated
files so application consumers do not need to run builders. CI verifies that the
committed output matches the definitions. Pigeon transport classes are generated
independently from the Pigeon contract.
