# Security

tv-revamp uses ADB to change packages on a TV and sideload a launcher. I treat USB and network debugging as full device access; turn debugging off when a session is done (`tools/adb-closed.py`).

## Reporting

Open a private security advisory on this repository's GitHub **Security** tab, or contact me through my GitHub profile. Do not post exploit details in public issues.

Include what is affected (tools, launcher, or session scripts), steps to reproduce, and impact.

## Scope

- Launcher (`com.gathin.tvhome`) must not use the network permission or expose data beyond its documented behaviour.
- Tools must not run shell on unintended hosts or mishandle paths and user input.
- Debloat steps must remain reversible with `tools/restore.sh` or documented undo scripts.
