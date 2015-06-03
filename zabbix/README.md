
**Retrive parameters from zabbix client with running zabbix_agent**

```bash
zabbix_get -s 192.168.128.1 -k vfs.fs.discovery | python -mjson.tool
...
zabbix_get -s 127.0.0.1 -p 10050 -k "vfs.fs.discovery"
```
