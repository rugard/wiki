
**Rename a logical volume **

```
lvrename /dev/vg02/lvold /dev/vg02/lvnew
```


**lvs - error: read failed after 0 of 4096**

```bash
lvs
dmsetup info /dev/dm-17
dmsetup remove /dev/dm-17
```

**SNAPSHOOTS experimenting:**

```bash
lvcreate -L1G -s -n pdc_wholeinstall_with_dns_and_chef /dev/sysraid/pdc-sda
# Do something with /dev/sysraid/virtualoriginal
# Revert
lvconvert --merge /dev/sysraid/pdc_wholeinstall_with_dns_and_chef

kpartx -d /dev/sysraid/virtualoriginal
lvchange -an /dev/sysraid/virtualoriginal
lvchange -ay /dev/sysraid/virtualoriginal
```
Then create snapshot already. Goto 1.
