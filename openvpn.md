# Openvpn tips

View/Count established connections with server, by parse logs

```bash
cat /var/log/openvpn.log | grep 'Peer Connection Initiated with' | grep 'gonch'
```
