## Fix flameshot on fractional scaling desktops (like my thinkpad)

- https://askubuntu.com/questions/1253394/fractional-scaling-flameshot-screenshot-problem-20-04
- https://github.com/lupoDharkael/flameshot/issues/564

### Autostart

`vim ~/.config/autostart/flameshot.desktop`

```
[Desktop Entry]
Type=Application
Exec=env QT_AUTO_SCREEN_SCALE_FACTOR=1 /usr/bin/flameshot
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name[en_US]=Flameshot
Name=Flameshot
Comment[en_US]=
Comment=
```

`vim ~/.profile`

```
# Fix flameshot run on 20.04 with scaling

export QT_AUTO_SCREEN_SCALE_FACTOR=1
```


Keyboard shortcuts to switch layout

```
dconf read /org/gnome/desktop/input-sources/xkb-options

dconf write /org/gnome/desktop/input-sources/xkb-options "['grp:alt_shift_toggle']"

dconf reset /org/gnome/desktop/input-sources/xkb-options

dconf read /org/gnome/desktop/input-sources/xkb-options
```
