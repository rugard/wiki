# Обновление unattend-upgrades в xenial (16.04)

В 16.04 не используется cron для запуска unattend-upgrades, точнее `/usr/lib/apt/apt.systemd.daily`, который ранее был `/etc/cron.daily/apt`

Теперь вместо крона используется systemd timer `/etc/systemd/system/timers.target.wants/apt-daily.timer`

Который также умеет рандомизировать время `RandomizedDelaySec=12h`

А cron job `/etc/cron.daily/apt` делает exit 0, в случае если запущен systemd. Т.е. он нужен в случае если systemd будет удален или не будет использоваться.

