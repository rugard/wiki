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
