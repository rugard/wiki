# Обновление unattend-upgrades в xenial (16.04)

В 16.04 не используется cron для запуска unattend-upgrades, точнее `/usr/lib/apt/apt.systemd.daily`, который ранее был `/etc/cron.daily/apt`

Теперь вместо крона используется systemd timer `/lib/systemd/system/apt-daily.timer` и `/etc/systemd/system/timers.target.wants/apt-daily.timer`. В чем отличия незнаю. diff = 0

Который также умеет рандомизировать время `RandomizedDelaySec=12h`

А cron job `/etc/cron.daily/apt` делает exit 0, в случае если запущен systemd. Т.е. он нужен в случае если systemd будет удален или не будет использоваться.

Таймер должен быть привязан к службе. В нашем случае это `/lib/systemd/system/apt-daily.service`

Подробнее здесь https://wiki.archlinux.org/index.php/Systemd/Timers_(%D0%A0%D1%83%D1%81%D1%81%D0%BA%D0%B8%D0%B9)

В нашем случае именно таймер `/lib/systemd/system/apt-daily.timer` запускает сервис `/lib/systemd/system/apt-daily.service` согласно `OnCalendar`. Потому, что каждому таймеру `name.time` должен соответсвовать сервис `name.service`.

Для того, чтобы увидеть все запущенные таймеры, используйте:

```
sysadmin@hyperion:~$ systemctl list-timers
NEXT                         LEFT         LAST                         PASSED       UNIT                         ACTIVATES
Wed 2016-09-14 15:29:51 MSK  4h 3min left Wed 2016-09-14 10:10:14 MSK  1h 15min ago snapd.refresh.timer          snapd.refresh.service
Thu 2016-09-15 03:23:42 MSK  15h left     Wed 2016-09-14 07:33:14 MSK  3h 52min ago apt-daily.timer              apt-daily.service
Thu 2016-09-15 05:47:19 MSK  18h left     Wed 2016-09-14 05:47:19 MSK  5h 38min ago systemd-tmpfiles-clean.timer systemd-tmpfiles-clean.service
n/a                          n/a          Thu 2016-09-08 15:03:55 MSK  5 days ago   ureadahead-stop.timer        ureadahead-stop.service

4 timers listed.
Pass --all to see loaded but inactive timers, too.

```

По умолчанию проверка и установка обновлений сильно рандомозирована, для снижения нагрузки на сервера. Мы это изменим.


