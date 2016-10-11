
# How to setup policy based routing and recursive routing on mikrotik.

Большей частью копипаст Кирилла Васильева, но с моим окружением.

```
ssh admin@192.168.129.1
```

Проверим настройку masquarade `/ip firewall nat print`

Для каждого внешнего интерфейса он должен делаться.

```
[admin@MikroTik] /ip firewall mangle> /ip firewall nat print
Flags: X - disabled, I - invalid, D - dynamic 
 0    ;;; default configuration
      chain=srcnat action=masquerade out-interface=pppoe-rt log=no log-prefix="" 

 1 X  chain=dstnat action=netmap to-addresses=192.168.129.100 to-ports=22 protocol=tcp src-address=93.178.105.67 in-interface=pppoe-rt 
      dst-port=2222 log=yes log-prefix="dstnat-2222-to-22-mercury" 

 2    chain=dstnat action=netmap to-addresses=192.168.129.100 to-ports=22 protocol=tcp in-interface=pppoe-mts dst-port=443 log=no log-prefix="" 

 3    chain=srcnat action=masquerade out-interface=pppoe-mts log=no log-prefix="" 
```

Добавим там где это нужно. У меня микротик добавляет правило для первого провайдера автоматически.

```
/ip firewall nat
add action=masquerade chain=srcnat out-interface=pppoe-rt
add action=masquerade chain=srcnat out-interface=pppoe-mts
```


Настроим маркировку **входящих соединений** и **исходящих пакетов**.
Первое правило маркирует соединения, второй исходящие пакеты.

> Информация о маркировке пакетов ни куда не передается и хранится исключительно на роутере.

Правила цепочки mangle для первого провайдера:

```
/ip firewall mangle
add action=mark-connection chain=input in-interface=pppoe-rt new-connection-mark=Input/ISP1
add action=mark-routing chain=output connection-mark=Input/ISP1 new-routing-mark=ISP1 passthrough=no
```

Правила цепочки mangle для второго провайдера:

```
/ip firewall mangle
add action=mark-connection chain=input in-interface=pppoe-mts new-connection-mark=Input/ISP2
add action=mark-routing chain=output connection-mark=Input/ISP2 new-routing-mark=ISP2 passthrough=no
```

Создадим правила Route для первого провайдера

```
/ip route rule
add action=lookup-only-in-table routing-mark=ISP1 table=ISP1
```

Создадим правила Route для второго провайдера

```
/ip route rule
add action=lookup-only-in-table routing-mark=ISP2 table=ISP2
```

Осталось дело за малым. Настроить таблицу маршрутизации для двух провайдеров.
Создадим маршруты для наших провайдеров

How and why we can use iface name instead of gateway ip in routing rules with ppp ifaces ?

> For PPP, tunnels, PVCs, or any non-multi-access type of interface, there's only you and "the other end" - so this makes sense.

See `http://forum.mikrotik.com/viewtopic.php?t=94191`

```
/ip route
add distance=1 gateway=pppoe-rt routing-mark=ISP1
add distance=1 gateway=pppoe-mts routing-mark=ISP2
```

Добавим два адреса через которых мы будем строить рекурсивные запросы.

```
/ip route
add distance=1 dst-address=8.8.4.4/32 gateway=pppoe-mts
add distance=1 dst-address=8.8.8.8/32 gateway=pppoe-rt
```

Ну и собственно сами рекурсивные маршруты, обратите внимание на target-scope

```
/ip route
add check-gateway=ping distance=10 gateway=8.8.8.8 target-scope=30
add check-gateway=ping distance=20 gateway=8.8.4.4 target-scope=30
```


#### Some useful links:

> https://www.vasilevkirill.com/MikroTik/1/
> 
> https://geektimes.ru/post/186284/
> 
> http://wiki.mikrotik.com/wiki/Advanced_Routing_Failover_without_Scripting
>
> http://wiki.mikrotik.com/wiki/Manual:IP/Firewall/Mangle

