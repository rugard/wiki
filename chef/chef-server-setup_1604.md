# Create a container

```bash
lxc init cvl_ubuntu_1604/base/latest chef
lxc start chef
lxc exec chef bash
```
Configure network:

Setup interfaces:

```
# The primary network interface
#auto eth0
#iface eth0 inet dhcp

auto eth0
iface eth0 inet static
        address 192.168.128.4
        netmask 255.255.255.0
        gateway 192.168.128.1

        dns-search cvision.lab
        dns-nameservers 192.168.128.3
```

Setup fqdn:

```
127.0.0.1   localhost
192.168.128.4 chef.cvisionlab.com chef

# The following lines are desirable for IPv6 capable hosts
::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
```

Reboot:

```bash
reboot
```

Check resolving:

```bash
apt-get update
apt-get install dnsutils

root@chef:~# nslookup mimas
Server:		192.168.128.3
Address:	192.168.128.3#53

Name:	mimas.cvision.lab
Address: 192.168.128.68

root@chef:~# hostname -f
chef.cvisionlab.com

```

Setup NOPASSWD:

```bash
root@chef:/home/srvadm# grep NOP /etc/sudoers
%sudo	ALL=(ALL:ALL) NOPASSWD:ALL
```

Copy keys:

```bash
skubriev@mimas$ ssh-copy-id srvadm@chef.cvisionlab.com
```

Prepare:

```
knife solo bootstrap srvadm@chef.cvisionlab.com
```
