# Setting up routing with multiple gateways

Следуя: http://habrahabr.ru/post/108690/

Как работает CONNMARK и MARK. И о том, что iproute2 не видит CONNMARK-ки!

http://nerdboys.com/2006/05/05/conning-the-mark-multiwan-connections-using-iptables-mark-connmark-and-iproute2/

## How chains(tables) is work ?

INPUT, FORWARD, and OUTPUT are separate. A packet will only hit one of the three chains.

If the destination is to this server, it hits the INPUT chain. If its source is from this server, it hits OUTPUT. If its source and destination are both other machines—it's being routed through the server—then it hits the FORWARD chain.

**Logging**

```
iptables -t filter -I FORWARD -d 83.221.209.54 -p tcp -m tcp --sport 21 -j LOG --log-prefix "log11 "
```

## About CONNMARK

The most common CONNMARK setup consist in putting connection mark on packet when they arrive and saving packet mark to connection when they leave. In term of iptables, this translates as:

iptables -A PREROUTING -t mangle -j CONNMARK --restore-mark
iptables -A POSTROUTING -t mangle -j CONNMARK --save-mark



## ip route tips

`proto kernel` - задаеться автоматически ядром при задании IP адреса интерфейсу.

`scope link` - запись являеться действительной только для этого интерфейса.

`scope host` - запись действительная только для этого хоста(используется в таблице local)

`src` - задает IP-адрес отправителя для пакетов, попадающих под это правило роутинга.

Изначально предопределены таблицы `local`, `main` и `default`.

В таблицу `local` ядро заносит записи для локальных IP адресов (чтобы трафик на эти IP-адреса оставался локальным и не пытался уходить во внешнюю сеть), а также для бродкастов. 

Таблица `main` является основной и именно она используется, если в команде не указано какую таблицу использовать (т.е. выше мы видели именно таблицу main).

Таблица `default` изначально пуста.

## Суть  PBR (policy based routing)

Для каждого провайдера определяем таблицу с правилом маршрутизации по умолчанию из сети провайдера.


Из `ip route | grep ethtop | grep 'proto kernel' | cut -d ' ' -f 1`




## 1. Заранее описать таблицы по именам (алиасы) в  /etc/iproute2/rt_tables

Изменения подгружаются автоматически.

```bash
101     isc-ml
102     isc-ts
```

Теперь можно использовать имена в ip rule команде например так: `lookup isc-ml`

## 2. Задайте маршруты по умолчанию в отдельной таблице для каждого провайдера

Это первое и самое главное условие для доступности сервера по двум внешний интерфейсам. его необходимо выполнить для того, чтобы маршрутизации пакетов работала для самих внешних интерфейсов.

Существует два метода:

* использовать самописный скрипт в init.d 

* использовать штатную систему debian ifupdown

Мы будем использовать штатную систему.

**Конфигурация через штатную систему может быть выполнена двумя методами:**

Автоматически с помощью generic скрипта, например как описывает автор:

There are exiting script to setup generic routes for all interfaces:
http://serverfault.com/questions/487939/permanently-adding-source-policy-routing-rules/487962#487962

**Вручную для каждого интерфейса.**

Мы остановимся на варианте вручную, т.к. он более гибок.

Данный вариант подразумевает настройку через post-up, post-down опции в конфигурационном файле /etc/network/interfaces

## 3. Задайте маршрут по умолчанию. 

После того, как маршрутизация для IP на внеших интерфейсах настроена, переходим к вопросу маршрута по умолчанию.

Без маршрута по умолчанию Интернет работать не будет.

В случае использования dhcp для настройки одного из интерфейсов провайдеров, маршрут по умолчанию будет установлен через протокол dhcp. Например так: `default via 192.168.1.1 dev ethtop`

Существует несколько методов определения маршрута по умолчанию:

### Статический маршрут в таблице main

Например заданный ifupdown через interfaces опцией gateway или полученный через dhcp.

Для установки маршрута по умолчанию вручную используйте команды:
```bash
# delete default route:
ip route del default

# add default route:

ip route add default dev ethtop
# or
ip route add default dev ethmiddle
# or
ip route add default dev ppp60

```

Мы будем использовать именно этот способ.

### Using Load balancing:

http://lartc.org/howto/lartc.rpdb.multiple-links.html

```bash
ip route add default scope global \
nexthop via $P1 dev $IF1 weight 1 \
nexthop via $P2 dev $IF2 weight 1
```

Не стабилен - не наш вариант.

This will balance the routes over both providers. The weight parameters can be tweaked to favor one provider over the other.
Note that balancing will not be perfect, as it is route based, and routes are cached. This means that routes to often-used sites will always be over the same provider.

See also `gc_timeout` kernel setting fix route switching time.

### Failover 

Необходим скрипт для переключения шлюзов. Пример есть здесь:

http://blog.hye.moe/post/2589
