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

### Install ruby gems

By default openSUSE messes with the name of installed gems, Use `gem install --no-format-executable` to prevent that. Also, `--user-install` can be helpful to install to a directory in the user's home.

### Fixing Firefox right-click menu on bspwm:

Apparently window borders fuck with the mouse positioning. This snipped in *userChrome* is a workaround:

```
#contentAreaContextMenu {
    margin: 10px 0 0 10px
}
```

### Shut up the sound card beeping

Soundcard somehow beeps audibly when on powersave.
Adding the following line to `/etc/modprobe.d/50-alsa.conf` shuts it up:

```
options snd-hda-intel power_save=0
```

### feh crashing because of missing fonts

Packaging bug, but whatever, just link stuff to where feh expects it:

```
sudo ln -s /usr/share/feh/ /usr/local/share
```
