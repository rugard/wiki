# Using LXD

## Puring lxd, restore system availability through network.

```
# <ctrl+alt+f1>
# <ctrl+c>
# <srvadm>
# <password>
sudo apt-get purge -yq lxd
sudo ifdown br-en01
sudo ifup br-en01
```

```
rm /etc/apparmor.d/cache/usr.lib.lxd.lxd-bridge-proxy /etc/default/lxd-bridge
rm -rf /var/log/lxd
rm -rf /var/lib/lxd*
```

True install, without brokes network.
```
sudo ifdown br-en01
lxc profile edit default
```

Change `user.network_mode:` from `dhcp` to `link-local`

```
config:
  user.network_mode: link-local
```

Change: `parent:` to `br-en01`

> **If testing**
> Ensure that old container is down.
> Theoretically syncrepl can be broken when multiple sync endpoints is up.

Check:

```
lxc launch images:ubuntu/xenial xenial
lxc start xenial
lxc list # view ip of xenial, and then:
lxc stop xenial
lxc delete xenial
```

# Do not run `lxd init`
# That case will setup dhcp, ip protocol on bridge interface and brokes the system availability through network.


### Russian article about lxd on habr

https://habrahabr.ru/post/308400/

### Command line interface

https://github.com/lxc/lxd/blob/master/specs/command-line-user-experience.md

### Install on 14.04

https://github.com/rugard/wiki/blob/master/system/software/pinning.md

Install bash_completion profile:

```bash
root# wget https://raw.githubusercontent.com/arges/lxd/master/config/bash/lxc.in -O /etc/bash_completion.d/lxd
```

### Change bridge iface

```bash
lxc profile edit default
```

### Images

```bash
lxc remote add images images.linuxcontainers.org
lxc image list images:
```

**Create alias to use local (already downloaded) image:**

```
lxc image alias create ubuntu/xenial/amd64 e99dd6437665
```

### Publishing images

```
lxc stop ldap --force
lxc publish ldap --public --alias=ldap/bootstraped
```


### Install `lxcfs` on host

To pass error with starting up systemd in xenial.

```bash
sudo apt-get install lxcfs
```

### Start a new vm

```
lxc init images:ubuntu/trusty/amd64 trusty
lxc init images:ubuntu/xenial/amd64 xenial
```

### Stop a vm

> --force is used when guest init does not react to SIGPWR

```bash
lxc stop trusty
lxc stop xenial --force
```

### Setup a container autostart

```bash
lxc config get trusty boot.autostart
boot.autostart:

lxc config set trusty boot.autostart true

lxc config get trusty boot.autostart
boot.autostart: true
```

### Change lxd backend to btrfs

Note: 

> The btrfs backend is automatically used if /var/lib/lxd is on a btrfs filesystem.

```bash
lvcreate -nlxd -L 50G mdata
mkfs.btrfs /dev/mdata/lxd
mkdir /mnt/lxd
mount /dev/mdata/lxd /mnt/lxd/

service lxd stop
cp -a /var/lib/lxd/* /mnt/lxd/
rm -rf /var/lib/lxd/*
umount /mnt/lxd
echo "/dev/mdata/lxd /var/lib/lxd btrfs defaults 0 2" >> /etc/fstab
mount -a
ll /var/lib/lxd/
service lxd start
lxc init images:ubuntu/xenial/amd64 xenial
```

### Setting up client and server to communicate

See: https://github.com/lxc/lxd

#### Setting up server

```bash
root@server# apt-get install lxd
root@server# lxc config get core.trust_password
root@server# lxc config set core.trust_password asdf
root@server# lxc config get core.trust_password

root@server# netstat -alnp | grep 8443
root@server# lxc config get core.https_address
root@server# lxc config set core.https_address 0.0.0.0
root@server# lxc config get core.https_address
root@server# service lxd restart
```

#### Setting up client

```bash
user@client$ lxc remote list
user@client$ lxc remote add gate gate.cvision.lab --password asdf
```

#### Remove password on server

```bash
root@server# lxc config set core.trust_password ""
root@server# service lxd restart
```

### Copy images

`lxc image copy` is not implemented now.

https://github.com/lxc/lxd/issues/553
https://github.com/lxc/lxd/issues/1510

Therefore we use `export/scp/import`

```
lxc image export ldap/smb/latest /tmp/ldap-smb-latest.tgz
scp /tmp/ldap-smb-latest.tgz sysadmin@gate:
lxc image import ldap-smb-latest.tgz

lxc image alias create ldap/smb/latest c6223cee201c
lxc init ldap/smb/latest ldap
lxc config set ldap boot.autostart true
lxc start ldap
```

### Upgrade `lxd` from rc to 2.0

Press OK on the warning: `lxcbr0 is being replaced by lxdbr0`

Then run 

```
dpkg-reconfigure -p medium lxd
```

Would you like to setup a network bridge for LXD containers now? NO
Do you want to use an existing bridge? YES

Bridge interface name: br-eth0

!!! Answer 'No' to configuring ipv4 and ipv6.

## Testing container

```
lxc init images:ubuntu/xenial/amd64 xenial
lxc config set xenial volatile.eth0.hwaddr 00:16:3e:6f:cb:d8
lxc start xenial
lxc exec xenial bash
...
lxc publish xenial -f --alias xenial/chef/rnd/2
lxc exec xenial bash
...
lxc delete -f xenial
```
