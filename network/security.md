
**Detect hosts via arp**

```bash
arp -a -n
? (192.168.129.216) at 14:da:e9:e5:12:85 [ether] on br-eth0
? (192.168.128.1) at 50:46:5d:59:6c:c6 [ether] on eth2
? (192.168.129.202) at 80:61:8f:21:ad:37 [ether] on br-eth0
? (192.168.129.2) at 74:d4:35:75:00:67 [ether] on br-eth0
```

Udp scan ntp server

```bash
sudo nmap -sU -p123 192.168.0.10
```

Scan subnet:

```bash
sudo nmap -sL 192.168.128.* | grep '('                                                                                                                                                                              
Nmap scan report for gate.cvision.lab (192.168.1.1)
Nmap scan report for st.cvision.lab (192.168.1.2)
...
Nmap done: 256 IP addresses (0 hosts up) scanned in 0.01 seconds
```
