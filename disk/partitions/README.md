
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
