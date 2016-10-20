# Emulate with qemu.

1. Get an image of raspbian.

2. Get a kernel from https://github.com/dhruvvyas90/qemu-rpi-kernel

I used `kernel-qemu-4.4.12-jessie`, direct link is https://github.com/dhruvvyas90/qemu-rpi-kernel/raw/master/kernel-qemu-4.4.12-jessie

3. Run 

```bash
$ qemu-system-arm -kernel kernel-qemu-4.4.12-jessie -cpu arm1176 -m 256 -M versatilepb -append "root=/dev/sda2 panic=1 rootfstype=ext4 rw init=/bin/bash" -hda 2016-02-26-raspbian-jessie.img
```

