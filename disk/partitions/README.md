
Device to device:

```
e2fsck -f /dev/hddraid/data
partclone.ext4 -b -s /dev/hddraid/data -o /dev/fastraid250/fastdata
```

Copy fs on the fly (via ssh)

```
partclone.ext4 -c -s /dev/nvme0n1p7 -o - | ssh ubuntu@192.168.1.133 "sudo partclone.ext4 -r -o /dev/sda9 -s -"
```

**Remount rootfs from read-only to rw-mode in recovery mode**

```bash
mount -o remount,rw /
```
**See when partition is last mounted**

```bash
tune2fs -l /dev/mapper/sysraid-zeus--rootfs | grep -e 'Last mounted' -e 'Maximum mount'
```

## Using du

```bash
du -sh /* --exclude=/storage --exclude=/home
sudo du -s -BM /home/skubriev/* | sort -n
sudo du -s -BM /var/lib/lxc/* | sort -n
```

**File system flags**

> If 'Maximum mount' Value=-1 then, partition will never be checked

See flags on all partitons
```bash
for device in /dev/mapper/*;do tune2fs -l $device | grep -e 'Last mounted' -e 'Maximum mount';done
```

Set Check Forced to all mapper fs’s

```bash
for device in /dev/mapper/*;do tune2fs -c 1 $device;done
```

Force root fs to fsck at reboot

```bash
touch /forcefsck
reboot
```

Adjust how often fs will be checked

```bash
tune2fs -c 30 /dev/sda1
```
## Using lsblk

```bash
lsblk -o NAME,MODEL,FSTYPE,MOUNTPOINT
```
## Using dmsetup

```bash 
dmsetup ls
```
> minor version - is a dm-X

```
root@zeus:/home/srvadm# dmsetup info -c /dev/sysraid/mimasroot
root@zeus:/home/srvadm# dmsetup remove /dev/sysraid/mimasroot
Name          	Maj Min Stat Open Targ Event  UUID                                                           	 
sysraid-mimasroot 252  17 L--w	0	9  	0 LVM-ba1mgBD69ENfsjt0NG7zZKCAWSqjMrMv3JaKYviOl8n06r5O39yCxwn8PDccz7Ah
```
## Using ramdisk and test speed

```bash
sudo mkdir /mnt/ramfs
sudo mount -t ramfs -o size=2000M ramfs /mnt/ramfs
sudo cp one_mysql_several_moves/test.mp4 /mnt/ramfs/

\time -f "%e" cp test.mp4 /dev/null &
```
