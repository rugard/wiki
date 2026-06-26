# fix-bluetooth

`cat /usr/local/bin/fix-bluetooth`

```bash
#!/bin/bash

set -x

#https://share.google/aimode/3dWRS49CyMiosjw6H

# Проверяем, что скрипт запущен от root
if [ "$EUID" -ne 0 ]; then
  echo "Пожалуйста, запустите скрипт через sudo: sudo fix-bluetooth"
  exit 1
fi

echo "=== Запуск реанимации Bluetooth ==="

# 1. Пытаемся найти PCI-адрес xHCI контроллера, на котором «висит» usb3
PCI_DEV=$(basename $(readlink /sys/class/udc/*/device 2>/dev/null) 2>/dev/null)
if [ -z "$PCI_DEV" ]; then
    # Резервный точный поиск через sysfs для xHCI
    PCI_DEV=$(basename $(dirname $(readlink /sys/bus/usb/devices/usb3)))
fi

# Если автоматика не сработала, берем ваш проверенный адрес ThinkBook
if [ -z "$PCI_DEV" ] || [ "$PCI_DEV" = "devices" ]; then
    PCI_DEV="0000:00:14.0"
fi

echo "Найдено PCI-устройство USB-контроллера: $PCI_DEV"

# 2. Удаляем контроллер из шины PCI
echo "Отключаем USB-контроллер..."
echo "1" > "/sys/bus/pci/devices/${PCI_DEV}/remove"
sleep 2

# 3. Принудительно сканируем шину заново (подается питание)
echo "Включаем USB-контроллер и сканируем шину..."
echo "1" > /sys/bus/pci/rescan
sleep 3

# 4. Сбрасываем софтверные блокировки
echo "Снимаем блокировки rfkill..."
rfkill unblock bluetooth 2>/dev/null

# 5. Перезапускаем службу Bluetooth для надежности
echo "Перезапускаем службу BlueZ..."
systemctl restart bluetooth

# 6. Проверяем результат
echo "-----------------------------------"
if lsusb | grep -i bluetooth > /dev/null; then
    echo "Успех! Bluetooth-адаптер снова виден в системе:"
    lsusb | grep -i bluetooth
else
    echo "Ошибка: Адаптер не появился на шине USB. Попробуйте еще раз."
fi


```

## Keepassxc on 26.04 and wayland

```bash
sudo su
[Sat May 23 11:07:27 2026] traps: keepassxc[1098902] general protection fault ip:7624ad529bd8 sp:7fff89892668 error:0 in libQt5Gui.so.5.15.18[129bd8,7624ad4e2000+542000]
[Sat May 23 22:03:35 2026] OOM killer disabled.
[Sun May 24 08:55:56 2026] OOM killer enabled.
[Sun May 24 09:32:37 2026] traps: keepassxc[1363692] general protection fault ip:7f3402b29bd8 sp:7fffce2dd308 error:0 in libQt5Gui.so.5.15.18[129bd8,7f3402ae2000+542000]
[Sun May 24 19:55:43 2026] OOM killer disabled.
[Mon May 25 10:06:56 2026] OOM killer enabled.
```

```bash
sudo vim /usr/share/applications/org.keepassxc.KeePassXC.desktop

#Exec=keepassxc %f
Exec=env QT_QPA_PLATFORM=xcb keepassxc %f

# re-run,and go sleep

sudo strings /proc/1630835/environ | grep QT_QPA_PLATFORM
```

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

## Установка Firefox ESR на Ubuntu 20.04

Здесь собрана информация о том, что такое Firefox ESR, как правильно установить его на Ubuntu 20.04 рядом со стандартной версией (Snap) и как отличить его в меню.

## Что такое Firefox ESR?

**ESR (Extended Support Release)** — это специальная версия браузера для тех, кому стабильность важнее новизны. В отличие от обычного Firefox, ESR не получает функциональных обновлений в течение года, меняется только интерфейс и исправляются критические ошибки безопасности.

**Важно об одновременной работе:**
ESR устанавливается как **полностью отдельное приложение**. У него:
*   Свой исполняемый файл (`/usr/bin/firefox-esr`).
*   Свои системные папки.
*   **Свой собственный пустой профиль** (закладки, пароли и история из вашей основной версии Firefox в нем не появятся автоматически).

## Установка на Ubuntu 20.04

Для этой версии ОС лучше использовать классический метод подключения репозитория через отдельный `.list` файл.

https://support.mozilla.org/en-US/kb/install-firefox-linux#w_install-firefox-deb-package-for-debian-based-distributions

Выбираем старенькое `For Debian Bookworm and Older:`

**Установите ESR-версию:**
> Внимание! Ставим `firefox-esr`
> 
Чтобы система установила именно «консервативную» сборку, а не обновила существующий Snap-пакет, используйте эту команду:
```bash
sudo apt update && sudo apt install firefox-esr
```

## Настройка иконки (для отличия от Snap-версии)

Так как в системе теперь будет два браузера с похожими названиями, лучше сменить иконку для ESR, чтобы не путать их в меню.

1.  Скачайте официальный логотип Firefox ESR (например, [Firefox_ESR_logo.png]).
2.  Отредактируйте файл запуска, скопировав его в локальную папку приложений (рабочий способ, который вы проверили):
    ```bash
    cp /usr/share/applications/firefox-esr.desktop ~/.local/share/applications/
    ```
3.  Отредактируйте скопированный файл:
    ```bash
    nano ~/.local/share/applications/firefox-esr.desktop
    ```
4.  Найдите строку `Icon=...` и измените её на путь к скачанному PNG-файлу:
    ```
    Icon=/home/vskubriev/Yandex.Disk/personal/images/System/firefox-nightly.png
    ```

<img width="761" height="366" alt="image" src="https://github.com/user-attachments/assets/b5cb0340-e1ad-4934-8715-5069189c02a3" />


**Результат:** В меню приложений будет два браузера. Тот, что с новой иконкой и подписью "Firefox ESR" — это версия с долгой поддержкой.

Способ 1: Через about:config (индивидуально)
Этот способ сработает для конкретного профиля пользователя:
Введите в адресной строке about:config и нажмите Enter.
Нажмите «Принять риск и продолжить».
В поле поиска вставьте: media.peerconnection.enabled.
Двойным кликом переключите значение в false.
