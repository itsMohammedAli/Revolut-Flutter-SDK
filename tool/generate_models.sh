#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
dart run build_runner build
dart format lib/src/models
