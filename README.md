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
  Option "metamodes" "DP-4: nvidia-auto-select +0+0 {viewportin=1920x1080}, DP-3.1: nvidia-auto-select +1920+0, DP-3.2: nvidia-auto-select +3840+0"

EndSection
```
