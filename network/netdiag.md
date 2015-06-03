# Network diagnostics

## Using netstat

```bash
netstat -tn
```

>	-t only tcp active connections (without listen daemons)

>	-n do not resolve (reverse lookups)

```bash
netstat -un
```

>	-u only udp active connections (without listen daemons)

>	-n do not resolve (reverse lookups)

>other switches:

>	-c - display continuosly


## Network load with vpnstat

```
sysadmin@zeus:~$ vnstat -l
Monitoring eth0...    (press CTRL-C to stop)

   rx:      156 kbit/s   200 p/s          tx:      208 kbit/s   170 p/s^C


 eth0  /  traffic statistics

                           rx         |       tx
--------------------------------------+------------------
  bytes                      640 KiB  |        7.83 MiB
--------------------------------------+------------------
          max             944 kbit/s  |    21.68 Mbit/s
      average          256.00 kbit/s  |     3.21 Mbit/s
          min             124 kbit/s  |      148 kbit/s
--------------------------------------+------------------
  packets                       6800  |            7914
--------------------------------------+------------------
          max               1563 p/s  |        2003 p/s
      average                340 p/s  |         395 p/s
          min                135 p/s  |         129 p/s
--------------------------------------+------------------
  time                    20 seconds


```
