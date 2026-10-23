# Redo this Toshiba from scratch

Clean this set the same way again. Do the work on the TV, over ADB, and check each step with a screenshot from the TV. Ask before changing a choice below.

## The set

Toshiba TV with MIC. Hisense board, product `songshan_emT_FFM`, device `songshan`, platform `m7632`, Android 11, SDK 30, firmware `RTT2.220118.001`. About 1.8 GB RAM. Wi-Fi, not USB Ethernet. Nothing in the USB ports. `ro.adb.secure=1`.

Find it on the LAN (it advertises `_adb._tcp` as `Android.local` port 5555). Use `tools/tv.py` from a venv with `adb-shell`, not the stock `adb` binary, if macOS answers "No route to host" while the port is open. Do not scan the LAN if a Tailscale address is given.

Back up `pm list packages`, `pm list packages -d`, `getprop`, and `settings list system|secure|global` before the first change.

## Do not disable

Live TV and the HDMI path: `com.mediatek.wwtv.tvcenter`, `com.mediatek.tv.service`, `com.hisense.tv.hitvinput`, `com.vt.tv.input`, and every other `com.mediatek.*` package.

These three send this family to recovery if they are disabled: `com.hisense.tv.smartsense`, `com.vt.tv.smartsense.ui`, `com.vt.tv.aiot`.

Also leave `com.hisense.tv.protector`, `com.hisense.tv.customerlauncher`, `com.hisense.tv.smartservice`, `com.vt.tv.commonui`, `com.google.android.sss.authbridge`, the Google Latin IME, Play Store, Play Services, and Android's core packages (`com.android.permissioncontroller` and the rest of the list `tools/disable.sh` refuses).

Do not launch `com.hisense.uifac` or any package whose name says factory. `dumpsys package` is enough.

## Disable

`pm disable-user --user 0`, one package per shell call, in small batches, with a screenshot between batches:

- `com.hisense.storemode`
- `fusion.android.tv.demo`
- `com.hisense.fte`
- `android.autoinstalls.config.google.gtvpai`
- `com.mstar.android.tv.disclaimercustomization`
- `com.google.android.feedback`
- `com.hisense.uifac`
- `com.google.android.apps.tv.dreamx`
- `com.google.android.youtube.tvmusic`
- `tv.airtel.xstream.tvapp`
- `com.jio.media.stb.ondemand`
- `com.crunchyroll.crunchyroid`
- `com.otl.tarangplustv`
- `org.videolan.vlc`
- `com.mxtech.videoplayer.television`
- `com.google.android.videos`
- `com.google.android.play.games`
- `com.hisense.hibrowser`

Reboot once and compare `pm list packages -d`. On this firmware they stayed disabled.

## Keep

YouTube, Netflix, Prime Video, Hotstar (`in.startv.hotstar`), Apple TV, Sony LIV, Zee5 (`com.graymatrix.did`), CloudStream, Cx File Explorer, LocalSend, USB Media Center (`com.vt.tv.mediacenter`), Google Assistant (`com.google.android.katniss` and `com.google.android.tv.assistant`), Chromecast (`com.google.android.apps.mediashell`), Miracast (`com.vt.miracast`), DLNA (`com.hisense.tv.dlna`), Smart Connect, HomeKit (`com.vt.tv.homekitproxy`), the OTA packages (`com.hisense.tv.ota`, `com.hisense.remoteupgrade`, `com.vt.tv.usbota`, `com.vt.audio_update_service`), and Aerial Views (`com.neilturner.aerialviews`). Aerial Views is the screensaver. Do not remove it.

## Setup wizard, then the launcher

`com.google.android.tungsten.setupwraith` claims Home. Disable it only after `dumpsys wifi` shows the connected network is owned by `android.uid.system`. It also owns one unused saved network, which Android deletes. `tools/disable.sh` will skip it unless `FORCE_SETUPWRAITH=1`. Confirm ADB still answers immediately after.

Build `launcher/` (minSdk 26, JDK 17) and install with `launcher/build-and-install.sh`. That disables `com.google.android.apps.tv.launcherx` only after the new activity has started. Confirm with `dumpsys activity activities | grep mFocusedApp`. Do not enable `INPUT_KEY_SERVICE` or `HOME_KEY_SERVICE` in that same pass.

Push `work/theme` with `tools/theme.sh`. Dock is four apps, in order: `com.google.android.youtube.tv`, `com.netflix.ninja`, `com.lagradost.cloudstream3`, `com.amazon.amazonvideo.livingroom`. Glass dock, cinematic title, app-coloured glow, no advanced effects, wallpapers rotating every 300 minutes. Check Inputs (HDMI, AV, Live TV), Up from the dock into the pills, and Down into the grid, each with a screenshot.

Private DNS is on: `settings put global private_dns_specifier dns.adguard-dns.com`, then `settings put global private_dns_mode hostname`. It does not block YouTube ads. Undo is `private_dns_mode opportunistic`. After setting it, open YouTube and confirm playback (`dumpsys media_session`, state 3). A black screenshot of YouTube is the TV, not a failed launch.

Map the dead remote buttons in the theme, then bind both helpers. YouTube is keycode 293, Prime Video is 295 (`app_keys`, `InputKeyService`), the gear is keycode 83 (`settings_key_keycodes`, `HomeKeyService`). Netflix and Input already work on this remote without a helper. Tell the owner that a held volume button may become one step per press, and ask them to hold Volume Up on the real remote. An injected key is not proof.

When the remote's app, Input, and Settings buttons have been checked, turn USB debugging and network ADB off, revoke the USB debugging authorisations, reboot, and confirm port 5555 refuses the connection with `tools/adb-closed.py`.
