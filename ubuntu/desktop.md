## Keyboard

```
curl https://service.cvisionlab.com/keyboard.sh

curl -s https://service.cvisionlab.com/keyboard.sh | bash
```

## Canon

Добавил принтер через cups с прото ipp:

```
ipp://192.168.107.75/
```
Драйвер выбрал ipp

```
avahi-browse -rt _ipp._tcp

sudo usermod -aG lpadmin vskubriev
```

> работает из консоли, из evince - нет

```
lp -d pixma "gemostazi В.С.pdf"
```

```
vskubriev@thinkpad-t16:~$ evince --version
GNOME Document Viewer 3.36.10
vskubriev@thinkpad-t16:~$ sudo snap install evince
evince 48.0 from Ken VanDine✪ installed
vskubriev@thinkpad-t16:~$ evince --version
GNOME Document Viewer 3.36.10

sudo apt-get remove evince
```

## HP

> https://bugs.launchpad.net/ubuntu/+source/hplip/+bug/1306344

```
sudo apt-get install python3-pyqt5
sudo ln -s /usr/share/hplip/sendfax.py /usr/bin/hp-sendfax
```

```
sudo hp-setup
```

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

### Start from cmd line

`vim ~/.profile`

```
# Fix flameshot run on 20.04 with scaling

export QT_AUTO_SCREEN_SCALE_FACTOR=1
```

### Start from default menu (unity)

Also fix default desktop file (always after install):

```
sudo vim /usr/share/applications/org.flameshot.Flameshot.desktop
```

and replace default `Exec=`




## Keyboard shortcuts to switch layout

```
dconf read /org/gnome/desktop/input-sources/xkb-options

dconf write /org/gnome/desktop/input-sources/xkb-options "['grp:alt_shift_toggle']"

dconf reset /org/gnome/desktop/input-sources/xkb-options

dconf read /org/gnome/desktop/input-sources/xkb-options
```
