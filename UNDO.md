# Undo

`./undo.sh` re-enables every package listed in `CHANGE.md`, makes the stock Google TV launcher Home again, and removes the sideloaded launcher.

```bash
TV_HOST=<tv ip> ./undo.sh
```

The TV has to be on, with USB debugging and network ADB on, and this computer allowed. Run it from the repo root after `tools/venv` exists.

## One app only

```bash
TV_HOST=<tv ip> tools/venv/bin/python -I tools/tv.py 'pm enable --user 0 <package>'
```

Package names are in `CHANGE.md`. Example, to bring YouTube Music back:

```bash
TV_HOST=<tv ip> tools/venv/bin/python -I tools/tv.py 'pm enable --user 0 com.google.android.youtube.tvmusic'
```

Press Home afterwards. If the icon is missing, reboot once.

## Dock, columns, wallpapers

Edit `work/theme/config.json`, then push it (no rebuild):

```bash
TV_HOST=<tv ip> tools/theme.sh work/theme
```

- `dock_apps` is the bottom row, left to right. Use the package names.
- `columns` is the dock width and the grid width. Keep it the same as the number of dock apps (4, 5, 6 or 7).
- Wallpapers are the JPEG files in `work/theme/wallpapers`. `wallpaper_rotation_minutes` is how long each one stays. `300` is 5 hours. `0` stops the rotation.
- `tools/theme.sh --reset` drops the theme and returns to the launcher's built-in look. The stock Google TV home stays disabled until you run `./undo.sh`.

## Private DNS

It is on: mode `hostname`, resolver `dns.adguard-dns.com`. It does not block ads inside YouTube. To turn it off:

```bash
TV_HOST=<tv ip> tools/venv/bin/python -I tools/tv.py 'settings put global private_dns_mode opportunistic'
```

## Remote buttons

YouTube (keycode 293), Prime Video (keycode 295) and the gear (keycode 83) go through the launcher's key helpers. `./undo.sh` removes the launcher, which removes those helpers too. To keep the launcher and only stop the helpers (this also restores a held volume ramp, if the helpers flattened it):

```bash
TV_HOST=<tv ip> tools/venv/bin/python -I tools/tv.py "settings put secure enabled_accessibility_services ''; settings put secure accessibility_enabled 0"
```

## What undo cannot restore

Disabling the setup wizard deleted one unused saved Wi-Fi network. The network the TV was on was not touched. Join the old network again in Settings if you still want it.
