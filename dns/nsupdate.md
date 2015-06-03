# Using nsupdate

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
