## Debug lxc-start

```
lxc-start -n backup -o /tmp/log -l DEBUG
```

## 18.04 lxc container with ifupdown

```
lxc-create -t download -n backup -- --dist ubuntu --release bionic --arch amd64
The cached copy has expired, re-downloading...
Setting up the GPG keyring
Downloading the image index
Downloading the rootfs
Downloading the metadata
The image cache is now ready
Unpacking the rootfs

---
You just created an Ubuntu bionic amd64 (20190123_07:43) container.

To enable SSH, run: apt install openssh-server
No default root or user password are set by LXC.

lxc-attach -n backup
```


To setup ifupdown see:

https://askubuntu.com/questions/1031709/ubuntu-18-04-switch-back-to-etc-network-interfaces

```
vim /etc/systemd/resolved.conf
```

```
[Resolve]
DNS=192.168.1.1
Domains=cvision.lab
```

```
systemctl restart systemd-resolved

ifdown --force eth0 lo
ifup -a

systemctl unmask networking
systemctl enable networking
systemctl restart networking

systemctl stop systemd-networkd.socket systemd-networkd
systemctl disable systemd-networkd.socket systemd-networkd
systemctl mask systemd-networkd.socket systemd-networkd
apt-get --assume-yes purge nplan netplan.io
```

All done !

## Чтобы работал lxc-stop контейнера с ubuntu 18.04

```
ln -s /lib/systemd/system/poweroff.target /etc/systemd/system/sigpwr.target
systemctl daemon-reload
```
