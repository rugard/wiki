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

## Reinstall ag notebook

Following: http://askubuntu.com/questions/21025/mount-a-luks-partition-at-boot

install a system only to root. Do not touch home partition !!!
Set the user name as existing ag username!

Next install cryptsetup in fresh installed ubuntu.

And 

Seems that I needed to edit the /etc/crypttab file, which is the crypto equivalent to fstab, and add the following line:

create a /dev/mapper device for the encrypted drive

```
home    /dev/sda2       none luks
And add the following to /etc/fstab:
```

```
# /home LUKS
/dev/mapper/home /home ext4 rw 0 0
```
Now I get two password prompts at boot, as needed.

AND THAT's all that I need.
