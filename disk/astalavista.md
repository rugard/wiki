
# 2022 July

Moving to raid1 ubuntu 20.04


## clean

```
mdadm --create --verbose /dev/md0 --level=1 --raid-devices=2 /dev/sda1 /dev/sdb1

vgchange -an sysraid

lvremove -f sysraid/home
lvremove -f sysraid/root
lvremove -f sysraid/swap

vgremove sysraid

pvremove /dev/md0
```

## create

```
pvcreate /dev/md0
vgcreate sysraid /dev/md0


lvcreate -nroot -L40G sysraid
lvcreate -nswap -L16G sysraid
lvcreate -nhome -L100G sysraid

mkfs.ext4 /dev/sysraid/home
mkswap /dev/sysraid/swap

mdadm --detail --scan
cat /etc/mdadm/mdadm.conf | grep ^ARR
ARRAY /dev/md0 metadata=1.2 name=astalavista:0 UUID=cd23d729:ce7ef238:b325a125:389b8685
reboot
```
