# Using CSI camera

> This cam module works only with Xserver enabled. And can be enabled software in GUI `raspiconfig` tool.

Additional info: https://www.raspberrypi.org/learning/getting-started-with-picamera/worksheet/

# Emulate with qemu.

## Get an image of raspbian.

## Get a kernel from https://github.com/dhruvvyas90/qemu-rpi-kernel

I used `kernel-qemu-4.4.12-jessie`, direct link is https://github.com/dhruvvyas90/qemu-rpi-kernel/raw/master/kernel-qemu-4.4.12-jessie

## Run with bash as init

```bash
$ qemu-system-arm -kernel kernel-qemu-4.4.12-jessie -cpu arm1176 -m 256 -M versatilepb -append "root=/dev/sda2 panic=1 rootfstype=ext4 rw init=/bin/bash" -hda 2016-02-26-raspbian-jessie.img
```

## Normal run

```
$ qemu-system-arm -kernel kernel-qemu-4.4.12-jessie -cpu arm1176 -m 256 -M versatilepb -append "root=/dev/sda2 panic=1 rootfstype=ext4 rw" -hda 2016-02-26-raspbian-jessie.img
```

# Change disk size

```bash
$ sudo su
# losetup /dev/loop0 2016-02-26-raspbian-jessie.img
# kpartx -a /dev/loop1
# e2fsck -f /dev/mapper/loop1p2
# resize2fs /dev/mapper/loop1p2
```

## Run with network and forwarding ssh port of guest to host system

> This will forward host localport 60022 to 22 port of guest (ssh server)

> Default user pi does not have ssh access enabled by default (we don't know why)

> Create you own user with password, and add it to sudoers

> To enable ssh server use `sudo raspi-config`

> Be sure that 60022 port is not used by another qemu|application on host system! Else you will get error.



```
$ qemu-system-arm -kernel kernel-qemu-4.4.12-jessie -cpu arm1176 -m 256 -M versatilepb -append "root=/dev/sda2 panic=1 rootfstype=ext4 rw" -hda 2016-02-26-raspbian-jessie.img -net nic -net user,hostfwd=tcp::60022-:22
```

Additional info

Good https://gist.github.com/Liryna/10710751

From lapin link https://wiki.ubuntu.com/ARM64/QEMU

Proc types https://developer.arm.com/products/processors/cortex-a/cortex-a53

# Setup chroot

```
sudo su
cd /tmp
wget https://downloads.raspberrypi.org/raspbian_lite_latest

unzip raspbian_lite_latest
rm raspbian_lite_latest

```

For `pip upgrade` and `apt-get update` without errors

```
#
root@raspberrypi:/tmp# mount —bind /dev/ /chroot/dev/
root@raspberrypi:/tmp# mount —bind /dev/pts /chroot/dev/pts
root@raspberrypi:/tmp# mount —bind /sys /chroot/sys
root@raspberrypi:/tmp# mount —bind /proc /chroot/proc

# /tmp must be created )
mkdir /tmp 
apt-get update
apt-get install python-pip
pip install --upgrade pip

```
