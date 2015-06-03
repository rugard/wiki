## Using nsupdate

```bash
root@pdc:/home/sysadmin# nsupdate -k /etc/bind/rndc.key
> update delete look.cvision.lab. a
> send
> update add look.cvision.lab. 900 a 192.168.1.11
> send
```bash

```bash
> update add 8.128.168.192.in-addr.arpa 900 ptr service.cvision.lab.
> send
```

## Lookups with host

```bash
host -l cvision.lab
...
host -l 128.168.192.in-addr.arpa.

```

## Avahi

```
avahi-browse --all -r | grep -C 4 apt
/usr/share/squid-deb-proxy-client/apt-avahi-discover
```


### dnsmasq and resolvconf

Если устанавливается dnsmasq то resolvconf ПРОПИШЕТ в /etc/resolv.conf nameserver 127.0.0.1

Текущие настройки dnsmasq запущенного NetworkManger

``` bash
cat /run/nm-dns-dnsmasq.conf
```
dnsmasq по умолчанию не нужен, т.к. он кэширует