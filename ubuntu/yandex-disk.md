# Yandex disk setup

Ссылки:

> - https://yandex.ru/support/disk-desktop-linux/installation.html
> - https://yandex.ru/support/disk-desktop-linux/cli-gui.html
> - https://github.com/slytomcat/yandex-disk-indicator/wiki/Yandex-disk-indicator
> - https://launchpad.net/~slytomcat/+archive/ubuntu/ppa

Установить по инструкции:

https://yandex.ru/support/disk-desktop-linux/installation.html

Установить yandex-disk-indicator:

https://github.com/slytomcat/yandex-disk-indicator/wiki/Yandex-disk-indicator#installation

Поправить ключ после его установки

```
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 60B9CD3A083A7A9A
# проверить что н аклююч не ругается
sudo apt-get update
```

