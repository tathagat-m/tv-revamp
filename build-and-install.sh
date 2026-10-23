#!/usr/bin/env bash
# Rebuild the launcher, install it as Home, and push this TV's glass theme.
# Usage, from the repo root:  TV_HOST=<tv ip> ./build-and-install.sh
set -euo pipefail
cd "$(dirname "$0")"
: "${TV_HOST:?Set TV_HOST to the TV's IP address}"
export JAVA_HOME="${JAVA_HOME:-/opt/homebrew/opt/openjdk@17}"
export ANDROID_HOME="${ANDROID_HOME:-/opt/homebrew/share/android-commandlinetools}"
export PATH="$JAVA_HOME/bin:$PATH"
launcher/build-and-install.sh
tools/theme.sh work/theme
echo "Theme pushed. Press Home on the remote."
