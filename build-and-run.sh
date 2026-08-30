#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BUILD_DIR="$ROOT_DIR/target/debug"

cd "$ROOT_DIR"
cargo build

mkdir -p "$BUILD_DIR"

if [ -d "$ROOT_DIR/data" ]; then
  rm -rf "$BUILD_DIR/data"
  cp -a "$ROOT_DIR/data/." "$BUILD_DIR/data/"
else
  rm -rf "$BUILD_DIR/data"
  mkdir -p "$BUILD_DIR/data"
fi

if [ -f "$ROOT_DIR/Doukutsu.exe" ]; then
  cp -f "$ROOT_DIR/Doukutsu.exe" "$BUILD_DIR/Doukutsu.exe"
fi

if [ -f "$ROOT_DIR/DoConfig.exe" ]; then
  cp -f "$ROOT_DIR/DoConfig.exe" "$BUILD_DIR/DoConfig.exe"
fi

if [ -d "$ROOT_DIR/data-overlay" ]; then
  cp -a "$ROOT_DIR/data-overlay/." "$BUILD_DIR/data/"
fi

cd "$BUILD_DIR"

if [ -f "$BUILD_DIR/miserysmeditation" ]; then
  exec "$BUILD_DIR/miserysmeditation"
fi

cd "$ROOT_DIR"

echo "Executable not found in $BUILD_DIR" >&2
exit 1
