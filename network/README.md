# Network 

## Network diagnostic

[Network Diagnostic](netdiag.md)

## Setup network

```
ip a add 192.168.0.10/24 dev br-eth0
ip a del 192.168.0.10/24 dev br-eth0
```

```
ip link set eth0 up
```

## setup routing to container network from developer machine

* setup docker host machine (for example pandora.cvision.lab)

```bash
echo "1" > /proc/sys/net/ipv4/ip_forward
```

* Setup route to container network for access from developer machine

```bash
route add -net 172.17.0.0 netmask 255.255.0.0 gw pandora.cvision.lab
```
