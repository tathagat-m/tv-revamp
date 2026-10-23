# This Toshiba

How to live with the clean home screen. The record of what changed is `CHANGE.md`. Putting the stock home back is `UNDO.md` and `./undo.sh`.

## Re-enable an app

```bash
TV_HOST=<tv ip> tools/venv/bin/python -I tools/tv.py 'pm enable --user 0 <package>'
```

The package names are in `CHANGE.md`. Press Home. Reboot if the icon does not show up.

## Dock order and wallpaper

`work/theme/config.json` is the look that is on the TV now.

- `dock_apps` — bottom row, left to right
- `columns` — same number as the dock (4, 5, 6 or 7)
- `work/theme/wallpapers/` — the photographs. Home moves to the next one every `wallpaper_rotation_minutes` (300, which is 5 hours), and only while Home is on screen
- `cinematic_art`, `cinematic_scrim`, `wallpaper_dim` — how strongly the focused app's colour and the dark gradient cover the photograph. Lower numbers show more of the picture

Push a change without rebuilding:

```bash
TV_HOST=<tv ip> tools/theme.sh work/theme
```

`TV_HOST=<tv ip> tools/theme.sh --reset` returns to the launcher's plain built-in look. The stock Google TV home stays off until `./undo.sh`.

Rebuild and reinstall, including the theme:

```bash
TV_HOST=<tv ip> ./build-and-install.sh
```

That needs JDK 17 and the Android SDK. `./undo.sh` is the reverse.

## Private DNS

On: `dns.adguard-dns.com`. It does not block ads inside YouTube. Turning it off is in `UNDO.md`.

## Remote buttons

YouTube, Prime Video and the gear button are handled by the launcher. Netflix and Input are handled by the TV itself. If a held volume button only moves one step, that is the helper, and the one-line undo is in `UNDO.md`.
