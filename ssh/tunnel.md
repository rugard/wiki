# SSH tunnels

**To connect server, that is placed behind a firewall/ssh server**

> This command forward localhost:3390 to 192.168.1.251:3389 remote server port.

Open tunnel and exit, tunnel run in background mode

```
ssh -v -N -L 3390:192.168.1.251:3389 srvadm@i.suntimes.ru -p 2283

```

> add -f, to run in background

Connect via rdp

```
rdesktop localhost:3390 -k en-us.fixed -r clipboard -u Администратор -K -g 1100x900
```
