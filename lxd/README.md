# Using LXD

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
