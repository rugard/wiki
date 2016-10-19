# Create a container

```bash
lxc init ubuntu/trusty/amd64 chef
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

> We do not use `chef.cvisionlab.com` as fqdn, because knife solo does not work, when node fqdn resolves to another than chef server ip (i.e. in gate ip)

> I already setuped resolving external name `chef.cvisionlab.com` on dns server and it resolves to internal gateway ip `192.168.128.1`. Chef server is immediately available with manage console.

```
127.0.0.1   localhost
192.168.128.4 chef.cvision.lab chef

# The following lines are desirable for IPv6 capable hosts
::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
```

Setup `/etc/inputrc`.

Setup NOPASSWD:

```bash
root@chef:/home/srvadm# grep NOP /etc/sudoers
%sudo	ALL=(ALL:ALL) NOPASSWD:ALL
```

Reboot:

```bash
reboot
```

Setup server admin:

```bash
lxc exec chef bash

deluser ubuntu
adduser srvadm
usermod -aG sudo srvadm

```

Check resolving, and ssh server:

```bash
apt-get update
apt-get -yq install dnsutils ssh

root@chef:~# nslookup mimas
Server:		192.168.128.3
Address:	192.168.128.3#53

Name:	mimas.cvision.lab
Address: 192.168.128.68

root@chef:~# hostname -f
chef.cvisionlab.com

```



Copy keys:

```bash
skubriev@mimas$ ssh-copy-id srvadm@chef.cvision.lab
```

Publish:

```
lxc image delete chef/bootstrapped
lxc publish chef --alias=chef/clean --force
```

## Bootstrap server

Prepare:

```
knife solo bootstrap srvadm@chef.cvision.lab

# or selective, first install chef, and then cook:
knife solo prepare srvadm@chef.cvision.lab
knife solo cook srvadm@chef.cvision.lab
```

## Initial configuration 

> https://docs.chef.io/install_server.html#standalone

Login to you server and disable history:

```bash
$ ssh srvadm@chef.cvision.lab

# become a root
$ sudo su

```

### Create initial user, be sure you place space before start commands, for 

```bash
# disable bash history
$ set +o history

# USAGE: knife opc user create USERNAME FIRST_NAME [MIDDLE_NAME] LAST_NAME EMAIL PASSWORD
# user=skubriev; chef-server-ctl user-create $user Vladimir Skubriev $user@cvisionlab.com 'password'--filename $user.pem 

# enable history
$ set -o history
```

Save a private key.

```
scp /tmp/skubriev.pem skubriev@mimas:.chef/skubriev.pem
```

Encrypt a pem file on admin machine:

```
# Be ready to enter a good password protection passphrase, below:
user="skubriev"; openssl rsa -aes256 -in ~/.chef/$user.key -out ~/.chef/$user.key
chmod 600  ~/.chef/$user.pem

```


### Create an org.

```bash

```
