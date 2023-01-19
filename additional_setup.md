## Disable PC Speaker

In file `/etc/modprobe.d/nobeep.conf`

```
blacklist pcspkr
```

## Backlight

`ls /sys/class/backlight/` will show the name, likely `intel_backlight` or
`acpi_video0`. Replace below accordingly

Then in file `/etc/udev/rules.d/backlight.rules`

```
ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="acpi_video0", GROUP="video", MODE="0664"
```

or for intel:

```
RUN+="/bin/chgrp video /sys/class/backlight/intel_backlight/brightness"
RUN+="/bin/chmod g+w /sys/class/backlight/intel_backlight/brightness"
```

## Systemd-boot timeout

In file `/boot/loader/loader.conf`

```
timeout 0
```

## Groups

Add your user to these groups:

```
sudo usermod -aG audio,video,wheel $USER
```

## Touchpad

In file `/etc/X11/xorg.conf.d/30-touchpad.conf`

```
Section "InputClass"
        Identifier "system-touchpad"
        MatchIsTouchpad "on"
        Option "Tapping" "on"
        Option "ClickMethod" "clickfinger"
        Option "NaturalScrolling" "true"
        Option "ScrollMethod" "twofinger"
EndSection
```

## Traditional network interface names

In file `/boot/loader/entries/<whatever>.conf`, add `net.ifnames=0` at end of
`options` line.

## Locales (add German)

In `/etc/locale.gen` uncomment `de_DE.UTF-8 UTF-8`, then run `sudo locale-gen`

## vim → nvim symlink

```
sudo ln -s "$(which nvim)" "$(dirname "$(which nvim)")/vim"
```

## Run slock on suspend

Create file `/etc/systemd/system/slock@.service`

```
[Unit]
Description=Lock X session using slock for user %i
Before=sleep.target

[Service]
User=%i
Environment=DISPLAY=:0
ExecStartPre=/usr/bin/xset dpms force suspend
ExecStart=/usr/bin/slock

[Install]
WantedBy=sleep.target
```

then run

```
sudo systemctl enable slock@$USER.service
```

## Hide ALSA warnings from some programs
