# dotfiles

## [openSUSE] configuration tips outside of per-user dotfiles:

### Hide kernel warnings on tty after boot

`sudo rm /usr/lib/systemd/system/getty@tty1.service.d/noclear.conf`

### Scale 4k screen that doesn't accept a lower resolution

Add to `/etc/X11/xorg.conf.d/50-screen.conf`:

```
Section "Screen"
  Identifier "Default Screen"
  Device "Default Device"
  Monitor "Default Monitor"
  Option "metamodes" "DP-4: nvidia-auto-select +0+0 {viewportin=1920x1080, ForceCompositionPipeline=On}, DP-3.1: nvidia-auto-select +1920+0 {ForceCompositionPipeline=On}, DP-3.2: nvidia-auto-select +3840+0 {ForceCompositionPipeline=On}"

EndSection
```

### Scale lightdm on 4k screen

Create '/etc/lightdm/lightdm.conf'

```
[SeatDefaults]
greeter-setup-script=/etc/profile.d/lightdm.sh
session-setup-script=/etc/profile.d/lightdm.sh
```

and the respective `/etc/profile.d/lightdm.sh`:

```
#! /bin/sh
if [ ! -z "$DISPLAY" ]; then
        /usr/bin/xrandr --output DP-4 --scale 0.5x0.5
fi
```
Don't forget to `chmod +x` that one!
