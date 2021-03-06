# Control disk devices.

## List devices

```
hdparm -I /dev/sd? | grep -e Model -e GB -e '^\/dev'
```

## Zap(Clean/Remove) GPT(primary,backup) and Protective MBR inside GPT

```
gdisk /dev/sdX
x
z
```

## Copy part table (GPT) from one to another disk:

https://askubuntu.com/questions/57908/how-can-i-quickly-copy-a-gpt-partition-scheme-from-one-hard-drive-to-another

The first command copies the partition table of sdX to sdY (be careful not to mix these up). The second command randomizes the GUID on the disk and all the partitions. This is only necessary if the disks are to be used in the same machine, 
otherwise it's unnecessary.

```
sgdisk /dev/sdX -R /dev/sdY 
sgdisk -G /dev/sdY
```

## Re-read partition table

```
partprobe
partprobe /dev/sdb
```

## Clear GPT partition.

Remeber, the GPT is both at the beginning and end of the disk. You must remove both of them.

```
disk=sdc; dd if=/dev/zero of=/dev/$disk bs=4096 count=35 seek=$(($(blockdev --getsz /dev/$disk)*512/4096 - 35))
# or
disk=sdc; sgdisk -Z /dev/$disk
```

Details: http://www.noah.org/wiki/Dd_-_Destroyer_of_Disks#Erase_GPT_.28GUID_Partition_Table.29

## Recovery

```bash
ddrescue --force --verbose --direct --max-retries=2 /dev/sda1 /dev/sde1 /tmp/1
```

Ей нужно три аргумента обязательных, это откуда, куда, и лог файл.
bad
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

**Determine corresponding beetween kernel ata and disk's device name**

http://superuser.com/questions/617192/mapping-ata-device-number-to-logical-device-name
http://serverfault.com/questions/244944/linux-ata-errors-translating-to-a-device-name

```bash
root@zeus:/home/sysadmin# ls -l /sys/block/sd?
lrwxrwxrwx 1 root root 0 Jun  7 13:31 /sys/block/sda -> ../devices/pci0000:00/0000:00:11.0/ata1/host0/target0:0:0/0:0:0:0/block/sda
lrwxrwxrwx 1 root root 0 Jun  7 13:31 /sys/block/sdb -> ../devices/pci0000:00/0000:00:11.0/ata2/host1/target1:0:0/1:0:0:0/block/sdb
lrwxrwxrwx 1 root root 0 Jun  7 13:31 /sys/block/sdc -> ../devices/pci0000:00/0000:00:11.0/ata3/host2/target2:0:0/2:0:0:0/block/sdc
lrwxrwxrwx 1 root root 0 Jun  7 13:31 /sys/block/sdd -> ../devices/pci0000:00/0000:00:11.0/ata4/host3/target3:0:0/3:0:0:0/block/sdd
lrwxrwxrwx 1 root root 0 Jun  7 13:31 /sys/block/sde -> ../devices/pci0000:00/0000:00:11.0/ata5/host4/target4:0:0/4:0:0:0/block/sde
```

```bash
root@zeus:/home/sysadmin# hdparm -I /dev/sd? | grep Model
	Model Number:       ST1000DM003-1ER162                      
	Model Number:       ST1000DM003-1ER162                      
	Model Number:       ST3000DM001-1CH166                      
	Model Number:       ST3000DM001-1CH166                      
	Model Number:       ST3000DM001-1ER166     
```

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

**View progress in stdout**

```bash
watch -n5 'sudo kill -USR1 $(pgrep ^dd)'
```

**Copy logical volume over network**

> Don't forget to add user on destination machine to disk group

```bash
usermod -aG disk srvadm
```

```bash
dd if=/dev/sysraid/serv1 | pv | gzip -c -9 | ssh srvadm@192.168.1.4 "gzip -dc | dd of=/dev/sysraid2/serv1"

# copy lvm with network
dd if=/dev/myvolumegroup/mylogicalvolume bs=4096 | pv | ssh targetmachine dd of=/dev/myvolumegroup/mylogicalvolume bs=4096

# Backup to backup server over ssh
dd if=/dev/sysraid/pdc-sda bs=64K | gzip -c | pv | ssh -c blowfish srvadm@backup dd of=/mnt/bigraid/backups/libvirt/pdc-sda.raw.gzip bs=64K

```

**Zero mbr**

```bash
dd if=/dev/zero of=/dev/sdX count=1 bs=512 && sync
```

## Using badblocks

Read-only testing is the default and doesn't need special parameters:

```bash
badblocks -sv /dev/sda
```

> -s Gives the process indicator

> -v Gives verbose

Write-Read with 5-x patterns:

```bash
wipefs -af /dev/sdc?
wipefs -af /dev/sdc
badblocks -fwsv /dev/sdc
```
> -f Don't check if device is in use. (use only if you think you're smarter than the badblocks program)

> -w - Use write-mode test.

Inspecting output:

```
2068270606ne, 11:56:22 elapsed. (0/9699/0 errors)
```
This means - errors while reading/writing/comparing

**Compressing virtualmachines images with qemu nbd**

```
modprobe nbd max_part=63
qemu-nbd -c /dev/nbd0 /var/lib/libvirt/images/vmdisk.qcow2 
ll /dev/nbd*
fdisk -l /dev/nbd0
apt-get install zerofree
zerofree /dev/nbd0p1

#Disconnect(remove device)

qemu-nbd -d /dev/nbd0

```

**Flush disk cache and buffers:**

```bash
sync && echo 3 > /proc/sys/vm/drop_caches
```

**Align 3Tb disk !!!**

Check what data is present(this helps to view disk sector size and parameters):

```
# cat /sys/block/sdb/queue/optimal_io_size
0
# cat /sys/block/sdb/queue/minimum_io_size
262144
```

Okey, let’s give minimal.
```
root@zeus:/home/srvadm# cat /sys/block/sdb/queue/minimum_io_size
4096
```

Run parted in help mode:

```
root@zeus:/home/srvadm# sudo parted -a minimal /dev/sdb
GNU Parted 2.3
Using /dev/sdb
Welcome to GNU Parted! Type 'help' to view a list of comma
mkpart primary 0% 100%

Check aligenment:

(parted) align-check
alignment type(min/opt)  [optimal]/minimal? min                      	 
Partition number? 1                                                  	 
1 aligned

Create fs on device:
mkfs.ext4 /dev/sdb2
```

## Unmount usb

```
udisksctl unmount -b /dev/sdc1
udisksctl power-off -b /dev/sdc1
```
