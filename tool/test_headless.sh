#!/usr/bin/env bash
# Run the same test files directly in Flutter's Linux engine, without sockets.
# Requires `flutter pub get` first. This is additional evidence, not a substitute
# for the instructor's required `flutter test` output on the final tagged commit.
set -euo pipefail
peer_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
peer_flutter_bin="${PEER_LEND_FLUTTER_BIN:-$(command -v flutter)}"
peer_sdk="$(dirname "$(dirname "$(readlink -f "$peer_flutter_bin")")")"
peer_engine="$peer_sdk/bin/cache/artifacts/engine/linux-x64"
peer_temp="$(mktemp -d)"
trap 'rm -rf "$peer_temp"' EXIT
cd "$peer_root"
if [[ ! -x "$peer_engine/flutter_tester" || ! -f .dart_tool/package_config.json ]]; then
  echo 'This fallback requires a Linux Flutter SDK and flutter pub get.' >&2
  exit 1
fi
# Construct the small asset bundle needed by these tests, without networking.
mkdir -p "$peer_temp/assets/fonts"
cp "$peer_sdk/bin/cache/artifacts/material_fonts/MaterialIcons-Regular.otf" "$peer_temp/assets/fonts/"
printf '%s\n' '[{"family":"MaterialIcons","fonts":[{"asset":"fonts/MaterialIcons-Regular.otf"}]}]' > "$peer_temp/assets/FontManifest.json"
# Material's ink/overscroll effects require the SDK's runtime shaders.
mkdir -p "$peer_temp/assets/shaders"
for peer_shader in "$peer_sdk/packages/flutter/lib/src/material/shaders/"*.frag; do
  peer_shader_name="$(basename "$peer_shader")"
  "$peer_engine/impellerc" --sksl --runtime-stage-vulkan --iplr \
    --sl="$peer_temp/assets/shaders/$peer_shader_name" \
    --spirv="$peer_temp/$peer_shader_name.spirv" --input="$peer_shader" \
    --input-type=frag --include="$(dirname "$peer_shader")" \
    --include="$peer_engine/shader_lib"
done
"$peer_sdk/bin/cache/dart-sdk/bin/dartaotruntime" \
  "$peer_sdk/bin/cache/dart-sdk/bin/snapshots/frontend_server_aot.dart.snapshot" \
  --sdk-root "$peer_sdk/bin/cache/artifacts/engine/common/flutter_patched_sdk" \
  --target=flutter --track-widget-creation --packages .dart_tool/package_config.json \
  --output-dill "$peer_temp/tests.dill" tool/headless_tests.dart > "$peer_temp/compile.log" 2>&1
if [[ ! -f "$peer_temp/tests.dill" ]]; then
  cat "$peer_temp/compile.log"
  exit 1
fi
FLUTTER_TEST=true "$peer_engine/flutter_tester" \
  --disable-vm-service --non-interactive --use-test-fonts --enable-software-rendering \
  --icu-data-file-path="$peer_engine/icudtl.dat" \
  --flutter-assets-dir="$peer_temp/assets" "$peer_temp/tests.dill" 2>&1 | tee "$peer_temp/results.log"
# Standalone test execution reports completion through the test reporter.
grep -q 'All tests passed!' "$peer_temp/results.log"
if grep -q 'Some tests failed' "$peer_temp/results.log"; then exit 1; fi
