# Control disk devices.

## Device avaibility

**Remove drive from system (sata and esata approved).**
First unmount all partitions from the device

```bash
sync && echo 1 > /sys/block/sdX/device/delete
```

**Park heads, sleep drive until there is no access to the drive.!**

```bash
hdparm -Y /dev/sdd
```

This will delete device from kernel. You will need to reinitialize device on the bus.

**Find out drive state:**

```bash
hdparm -C /dev/sdX
```
**Scan system bus for new devices**

```bash
apt-get install scsitools
rescan-scsi-bus
```

## Using dd

**Copy logical volume over network**

> Don't forget to add user on destination machine to disk group

```bash
usermod -aG disk srvadm
```

```bash
dd if=/dev/sysraid/serv1 | pv | gzip -c -9 | ssh srvadm@192.168.1.4 "gzip -dc | dd of=/dev/sysraid2/serv1"
```
## Using badblocks

Read-only testing is the default and doesn't need special parameters.

```bash
badblocks -sv /dev/sda
```

> -s gives the process indicator

> -v gives verbose
