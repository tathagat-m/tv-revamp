#!/usr/bin/env bash
# Put this Toshiba back to the stock Google TV home and re-enable every package
# disabled during the clean-up. Nothing was uninstalled from the system, so
# re-enabling is the whole undo. The sideloaded launcher is removed at the end.
#
# Usage, from the repo root:
#   TV_HOST=<tv ip> ./undo.sh
set -euo pipefail
cd "$(dirname "$0")"
: "${TV_HOST:?Set TV_HOST to the TV's IP address}"
PY=tools/venv/bin/python
[ -x "$PY" ] || { echo "missing $PY — create tools/venv and install tools/requirements.txt" >&2; exit 1; }

tv() { "$PY" -I tools/tv.py "$@"; }

# One pm command per shell call. The stock launcher has to be enabled before
# it can be made Home, and it has to be Home before the new launcher is removed.
PACKAGES=(
  com.google.android.apps.tv.launcherx
  com.google.android.tungsten.setupwraith
  com.hisense.storemode
  fusion.android.tv.demo
  com.hisense.fte
  android.autoinstalls.config.google.gtvpai
  com.mstar.android.tv.disclaimercustomization
  com.google.android.feedback
  com.hisense.uifac
  com.google.android.apps.tv.dreamx
  com.google.android.youtube.tvmusic
  tv.airtel.xstream.tvapp
  com.jio.media.stb.ondemand
  com.crunchyroll.crunchyroid
  com.otl.tarangplustv
  org.videolan.vlc
  com.mxtech.videoplayer.television
  com.google.android.videos
  com.google.android.play.games
  com.hisense.hibrowser
)

for pkg in "${PACKAGES[@]}"; do
  tv "pm enable --user 0 $pkg"
done

tv "cmd package set-home-activity --user 0 com.google.android.apps.tv.launcherx/.home.HomeActivity"
tv "pm uninstall com.gathin.tvhome" || true

echo "---- Home now ----"
tv "cmd package resolve-activity --brief -a android.intent.action.MAIN -c android.intent.category.HOME"
echo "---- still disabled ----"
tv "pm list packages -d"
echo "Done. Press Home on the remote. The stock Google TV launcher should be back."
echo "One unused Wi-Fi network that belonged to the setup wizard was deleted when that"
echo "wizard was disabled. The network the TV was using was not. Re-join the old one"
echo "in Settings if you still need it."
