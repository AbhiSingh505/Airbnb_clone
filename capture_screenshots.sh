#!/bin/bash

# Capture iOS Simulator screenshots into screenshots/ with friendly names
# Usage examples:
#   ./capture_screenshots.sh explore
#   ./capture_screenshots.sh search
#   ./capture_screenshots.sh property_detail
#   ./capture_screenshots.sh map
#
# If you pass a known alias, it will map to the numbered filenames used in README.
# If you pass a custom name, it will be saved as screenshots/<name>.png

set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "$0")" && pwd)"
SS_DIR="$PROJECT_ROOT/screenshots"
mkdir -p "$SS_DIR"

alias_to_filename() {
  case "$1" in
    explore) echo "01_Explore_View.png" ;;
    search) echo "02_Search_View.png" ;;
    property_detail|detail) echo "03_Property_Detail.png" ;;
    map) echo "04_Map_View.png" ;;
    tabbar|tab_bar) echo "09_Tab_Bar_Animation.png" ;;
    voice|voice_search|mic) echo "10_Voice_Search.png" ;;
    *) echo "$1.png" ;;
  esac
}

if ! command -v xcrun >/dev/null 2>&1 ; then
  echo "❌ xcrun not found. Please install Xcode command line tools."
  echo "Run: xcode-select --install"
  exit 1
fi

if ! xcrun simctl list | grep -q "Booted" ; then
  echo "ℹ️ No booted simulator detected. Attempting to boot the default iPhone..."
  DEVICE_ID=$(xcrun simctl list devices | grep -E "iPhone 15 Pro .* Shutdown" | head -n1 | awk -F '[()]' '{print $2}')
  if [ -n "${DEVICE_ID:-}" ]; then
    xcrun simctl boot "$DEVICE_ID" || true
    open -a Simulator
    echo "⏳ Waiting for simulator to boot..."
    sleep 8
  else
    echo "⚠️ Could not auto-detect an iPhone 15 Pro simulator. Please boot a simulator manually, then re-run."
    exit 1
  fi
fi

NAME_INPUT=${1:-}
if [ -z "$NAME_INPUT" ]; then
  echo "Usage: $0 <name|explore|search|property_detail|map|tabbar|voice>"
  exit 1
fi

FILENAME=$(alias_to_filename "$NAME_INPUT")
TARGET="$SS_DIR/$FILENAME"

# Take the screenshot from the currently booted simulator
xcrun simctl io booted screenshot "$TARGET"

if [ -f "$TARGET" ]; then
  echo "✅ Saved: $TARGET"
else
  echo "❌ Failed to save screenshot."
  exit 1
fi
