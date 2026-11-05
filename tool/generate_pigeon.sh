#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
dart run pigeon --input pigeons/revolut_api.dart
dart format lib/src/generated/revolut_api.g.dart
# Normalize generator whitespace so committed bindings pass git diff --check.
python3 - <<'PYTHON'
from pathlib import Path
for name in (
    'android/src/main/kotlin/com/revolutpay/flutter/generated/RevolutApi.g.kt',
    'ios/revolut_sdk_bridge/Sources/revolut_sdk_bridge/Generated/RevolutApi.g.swift',
):
    path = Path(name)
    path.write_text('\n'.join(line.rstrip() for line in path.read_text().splitlines()) + '\n')
PYTHON
