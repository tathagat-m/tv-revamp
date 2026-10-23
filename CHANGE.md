# Changes on this Toshiba

Toshiba TV with MIC, Hisense board `songshan` (`songshan_emT_FFM`, `m7632`), Android 11, SDK 30, firmware `RTT2.220118.001` / `01.03.05.04`. About 1.8 GB of RAM. On Wi-Fi. Nothing was plugged into USB. No USB Ethernet adapter.

Nothing was uninstalled from the system. Every package below was disabled with `pm disable-user --user 0`. Undo with `./undo.sh` (see `UNDO.md`).

A reboot after the first eighteen disables left all eighteen disabled. This firmware does not turn them back on at boot.

## Disabled

Retail and setup leftovers:

- `com.hisense.storemode`
- `fusion.android.tv.demo`
- `com.hisense.fte`
- `android.autoinstalls.config.google.gtvpai`
- `com.mstar.android.tv.disclaimercustomization`
- `com.google.android.tungsten.setupwraith` (its RecoveryActivity also claims Home; the network in use belongs to the system, so disabling it did not drop Wi-Fi. One unused saved network that belonged to the wizard was deleted.)
- `com.google.android.feedback`
- `com.hisense.uifac` (factory UI; it was not opened)
- `com.google.android.apps.tv.dreamx` (Google's ambient screensaver; Aerial Views stays the screensaver)

Apps left unticked:

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

Stock home, disabled only after `com.gathin.tvhome` was installed and confirmed focused:

- `com.google.android.apps.tv.launcherx`

## Left enabled on purpose

Live TV and HDMI (`com.mediatek.wwtv.tvcenter`, `com.mediatek.tv.service`, `com.hisense.tv.hitvinput`, `com.vt.tv.input`), every other `com.mediatek.*` package, `com.hisense.tv.smartsense`, `com.vt.tv.smartsense.ui`, `com.vt.tv.aiot`, `com.hisense.tv.protector`, `com.hisense.tv.customerlauncher`, `com.hisense.tv.smartservice`, the Google keyboard, Play Store, Play Services, and Android's own core packages.

Kept because you use them: YouTube, Netflix, Prime Video, Hotstar, Apple TV, Sony LIV, Zee5, CloudStream, Cx File Explorer, LocalSend, USB Media Center, Google Assistant, Chromecast, Miracast, DLNA, Smart Connect, HomeKit, and the firmware updaters. Aerial Views (`com.neilturner.aerialviews`) stays, and it is still the screensaver.

## Launcher

`com.gathin.tvhome` is the default Home. Confirmed with `dumpsys activity activities` (`mFocusedApp` is `com.gathin.tvhome/.MainActivity`), not only with `set-home-activity`.

Theme `work/theme`: four dock slots, YouTube, Netflix, CloudStream, Prime Video, glass dock, cinematic title and glow, frosted Inputs / Wi-Fi / Settings pills. Six open-license photographs in `work/theme/wallpapers` rotate every 300 minutes (5 hours). They are not Apple's macOS wallpapers. No blur, no video, no network polling, and wallpaper true-colour is off.

Display overrides were not touched. Physical size 1920x1080, density 320, `display_density_forced` empty.

Remote helpers, bound for the current user (`capabilities=8`):

- `InputKeyService` — YouTube keycode 293, Prime Video keycode 295 (same codes as the Hisense songshan list for this board)
- `HomeKeyService` — gear / Settings keycode 83

Netflix and Input already worked without a helper, so they are not remapped. Holding volume was checked on the real remote after the helpers were bound: it moves one step per press. That is the key-filter trade on this Android 11 board, not a broken remote. The owner chose to keep YouTube, Prime, and the gear. `settings put secure enabled_accessibility_services ''` and `accessibility_enabled 0` bring the ramp back and silence those three buttons again.

Private DNS is `hostname` / `dns.adguard-dns.com`. YouTube still reached `PlaybackState` state 3 (playing) afterwards. It does not block ads inside YouTube. Undo: `settings put global private_dns_mode opportunistic`.

USB debugging was switched off with `settings put global adb_enabled 0`. Wireless debugging was already off. Port 5555 then answered connection refused (`tools/adb-closed.py`). The shell cannot delete `/data/misc/adb/adb_keys`, so the USB debugging authorisations still have to be revoked on the TV, and the set still needs one reboot from the remote.
