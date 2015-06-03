
**Remount rootfs from read-only to rw-mode in recovery mode**

```bash
mount -o remount,rw /
```
**See when partition is last mounted**

```bash
tune2fs -l /dev/mapper/sysraid-zeus--rootfs | grep -e 'Last mounted' -e 'Maximum mount'
```
