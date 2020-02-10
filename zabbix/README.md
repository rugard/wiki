
**Force pull data from server on proxy when templates changed.  **

By default there is one per hour at same time:

> `root@lxc_zabbix:/etc/zabbix# grep -R ProxyConfigFrequency`
> `zabbix_server.conf:### Option: ProxyConfigFrequency`
> `zabbix_server.conf:# ProxyConfigFrequency=3600`

Force reload:

```bash
root@gate:/home/srvadm# zabbix_proxy -R config_cache_reload
zabbix_proxy [10928]: command sent successfully
```

**Retrive parameters from zabbix client with running zabbix_agent**

```bash
zabbix_get -s 192.168.128.1 -k vfs.fs.discovery | python -mjson.tool
...
zabbix_get -s 127.0.0.1 -p 10050 -k "vfs.fs.discovery"
```
