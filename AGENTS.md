# AGENTS.md

Instructions for coding agents working in **tv-revamp** — my Android TV / Google TV debloat and launcher project (`com.gathin.tvhome`, tools under `tools/`). Start with [README.md](README.md).

## First: which job?

| You were asked to | Do this |
|---|---|
| Clean a TV (debloat, launcher, theme) | Read [PROMPT.md](PROMPT.md) exactly. Use existing `tools/` and `launcher/`. Only change `launcher/app/src/main/res/values/config.xml` or a theme `config.json` for that TV unless the person asks for more. |
| Change this repo (docs, tools fix, launcher fix) | Follow the safety rules below and keep diffs small. Do not edit the session record files listed under **Frozen session files**. |

## Frozen session files

These document one TV session at my home. **Do not change** package lists, commands, or procedural steps inside them (only trivial typo fixes if the person asks):

- [PROMPT.md](PROMPT.md), [undo.sh](undo.sh), [build-and-install.sh](build-and-install.sh)
- [REDO-PROMPT.md](REDO-PROMPT.md), [CHANGE.md](CHANGE.md), [UNDO.md](UNDO.md), [TV-README.md](TV-README.md)

Do not treat Toshiba-specific text in those files as a project limitation: tv-revamp targets **any Android TV / Google TV**.

## Safety rules (non-negotiable)

These rules protect the TV; follow them on every session:

- **Disable, never uninstall.** `pm disable-user --user 0`, one package per shell call.
- **Back up first** into `backup/` before the first change.
- **Never disable core Android packages**; `tools/disable.sh`, `disable.ps1`, and `check.py --fix` refuse them.
- **Keep the Home guard:** stock launcher disabled only after `com.gathin.tvhome` is Home and focused.
- **Ask** before disabling streaming apps, voice assistant, Chromecast, Miracast, or firmware updaters.
- **Close ADB** when finished (USB/network debugging off, `tools/adb-closed.py`).

Full detail is in [PROMPT.md](PROMPT.md).

## Repo map

| Path | What it is |
|---|---|
| `PROMPT.md` | Paste-into-assistant procedure for any Android TV / Google TV |
| `launcher/` | Reference launcher (`com.gathin.tvhome`), `minSdk` 26, no `INTERNET` |
| `themes/` | Theme folders (`config.json`, wallpapers); see [themes/README.md](themes/README.md) |
| `tools/` | `tv.py`, `disable.sh`, `restore.sh`, `theme.sh`, `recovery.py`, `check.py`, and helpers |
| `docs/TROUBLESHOOTING.md` | Symptom → fix notes from real TVs (some links point at community device write-ups) |
| `docs/REMOTE.md` | Tailscale / remote ADB |
| `backup/`, `shots/`, `work/` | Gitignored session data |

## Before you finish

| Check | Command |
|---|---|
| Tests | `python3 -m venv tools/venv && tools/venv/bin/pip install -q -r tools/requirements.txt` then `python3 -m unittest discover -s tests -v` |
| Launcher (if you touched `launcher/`) | In `launcher/`: `./gradlew --no-daemon testReleaseUnitTest lintRelease assembleRelease` |
| APK size | `launcher/app/build/outputs/apk/release/app-release.apk` must be under 491,520 B (480 KB) |

CI runs the same unittest command on push to `main` (see [.github/workflows/ci.yml](.github/workflows/ci.yml)).

## Hard rules for this repo

- Work and pull requests belong on **tathagat-m/tv-revamp** only.
- No prebuilt APKs in git.
- No secrets or device identifiers in commits (IPs, Wi-Fi names, serials).
- Do not relax launcher `minSdk` 26 or add `INTERNET` without an explicit project decision.
