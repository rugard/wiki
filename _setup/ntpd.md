# Важно знать про конфигурацию ntp в ubuntu

1. Вне зависимости от статуса пакета ntp на машине (установлен или нет) работает ntpdate при поднятии интерфейса.
2. Если ntp конфигурируется через dhcp, то стартовый скрипт ntp из ubuntu 14.04 использует сгенерированный на лету конфиг `/var/lib/ntp/ntp.conf.dhcp` в котором есть основные интернет сервера и местный (выданный по dhcp). Следовательно конфигурация из /etc/ntp.conf ни на что не влияет. 

# Setting up ntp client and server

Хорошая статью про ntpq

http://citrin.ru/net:ntpq

Thanks to Yuri Kurenkov for a simple tips in how-to setup this.

Есть такой демон назвается ntpd - нужен он для того, что подкручивать локальные часы там где он стоит.

Еще он может отвечать на запросы.

В конфигурационном файле есть очень похожие директивы, задающие вышестоящие по отношению к настраиваему серверу машины. 

Например  такой вот сервер 1 или 2-го стратума:

> dns возвращает периодически сервера 1-го стартума по этим именам, но в основном по ним возвращаются сервера 2-го стратума

> наш сервер будет уже 3-им стратумом, т.е. стратум источника + 1

```
server 0.pool.ntp.org iburst minpoll 6 maxpoll 10
restrict 0.pool.ntp.org nomodify notrap noquery
```
и

`peer ntp1.cvision.lab iburst minpoll 6 maxpoll 10`

server - это узлы на которые он будет равняться.
peers - это узлы на которые он будет равняться, но локальные ваши серверы.

`peers` синхронизируют время между собой дополнительно к синхронизации с серверами 1,2 стартумов указываемых в server директивах. 



## ntpdate vs ntpd

Когда установлен пакет ntp, а следовательно ntpd, ntpq и т.д. ntpdate не работает!

```
root@mimas:/home/skubriev# ntpdate-debian 
28 Mar 18:24:28 ntpdate[17045]: the NTP socket is in use, exiting
```

## compare time on local and other my own servers (restrictions is disabled)

> public servers does not respond to this query type, because of restrictions

> to allow this requests over network, comment string like below:

> `#restrict default kod notrap nomodify nopeer noquery`

```
skubriev@mimas:~$ ntpq -c "rv 0 clock" ntp.cvision.lab localhost
server=ntp.cvision.lab clock=daa4c071.81fd9732  Tue, Mar 29 2016 11:50:57.507
server=localhost clock=daa4c071.742ca86d  Tue, Mar 29 2016 11:50:57.453
```

# Synchronize date and time with a server over ssh

> using -u is better for standardizing date output and timezones, for servers in different timezones.

```
date --set="$(ssh user@server 'date -u')"
```
