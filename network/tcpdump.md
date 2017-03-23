# tcpdump

```bash
tcpdump -i ppp60 'host i.suntimes.ru and port not 2283'
```

# tcpdump over ssh

```
ssh sysadmin@server sudo tcpdump -U -s0 'port 389 and not port 22 and host server.example.lab' -i br-eth0 -w - | wireshark -k -i -
```
