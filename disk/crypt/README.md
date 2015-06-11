# Crypt

Follow http://xgu.ru/wiki/LUKS

```bash
lvcreate -nfamily_backup -L140G bigraid
# run with space in the home of command
 echo secret_password | cryptsetup luksFormat /dev/bigraid/family_backup
cryptsetup luksOpen /dev/bigraid/family_backup family_backup
cryptsetup status family_backup
mkfs.ext4 /dev/mapper/family_backup
mkdir /mnt/family_backupd
mount /dev/mapper/family_backup /mnt/family_backup/

umount /mnt/family_backup/
cryptsetup luksClose family_backup
cryptsetup status family_backup
```
