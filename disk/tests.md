# Input/Output sub system performance tests

# TRUE TESTING with fio !!!

http://habrahabr.ru/post/154235/

## Testing ssh, smb, nfs protocols

Clear caches on client and server:

```bash
sync && echo 3 > /proc/sys/vm/drop_caches
```
Mount smb

```bash
mount -t cifs //zeus/common /mnt/samba/ --verbose -o user=skubriev
```

Mount nfs

```bash
mount zeus:/storage/shares /mnt/nfs_localmount/
```

```
```

**Test commands:**

```bash
tar cv - /storage/shares/common/skubriev/renderedfiles_1gb | dd of=/dev/null
dd video.avi | pv | dd of=/dev/null
dd if=/mnt/nfs_localmount/common/video.avi | pv | dd of=/dev/null
dd if=/dev/zero bs=16k count=64000 | ssh srvadm@zeus "cat > /tmp/testfile"
```
