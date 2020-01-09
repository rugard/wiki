# !!! Don't use gparted. When it will offer to fix GPT it will remove init info of soft dmraid !!!

## dmraid olya lazo

Info

```
root@ubuntu:/home/ubuntu# lsblk -f
NAME                          FSTYPE          LABEL                    UUID                                 MOUNTPOINT
loop0                         squashfs                                                                      /rofs
loop1                         squashfs                                                                      /snap/core/4917
loop2                         squashfs                                                                      /snap/gtk-common-themes/319
loop3                         squashfs                                                                      /snap/gnome-3-26-1604/70
loop4                         squashfs                                                                      /snap/gnome-calculator/180
loop5                         squashfs                                                                      /snap/gnome-characters/103
loop6                         squashfs                                                                      /snap/gnome-logs/37
loop7                         squashfs                                                                      /snap/gnome-system-monitor/51
sda                           isw_raid_member                                                              
└─isw_djbagheehb_VolumeSSD                                                                                  
  ├─isw_djbagheehb_VolumeSSD1                                                                              
  └─isw_djbagheehb_VolumeSSD2                                                                              
sdb                           isw_raid_member                                                              
└─isw_djbagheehb_VolumeSSD                                                                                  
  ├─isw_djbagheehb_VolumeSSD1                                                                              
  └─isw_djbagheehb_VolumeSSD2                                                                              
sdc                           isw_raid_member                                                              
└─isw_djfjjgcbic_Volume0                                                                                    
  ├─isw_djfjjgcbic_Volume0p1  ntfs            Зарезервировано системой 9278093C78092119                    
  ├─isw_djfjjgcbic_Volume0p2  ntfs                                     D2160B4F160B33CF                    
  ├─isw_djfjjgcbic_Volume0p3  ntfs            DATA                     C4DE7C3EDE7C2B36                    
  ├─isw_djfjjgcbic_Volume0p4                                                                                
  └─isw_djfjjgcbic_Volume0p5  ntfs            ACRONIS SZ               45AAFAAAD73AD535                    
sdd                           isw_raid_member                                                              
└─isw_djfjjgcbic_Volume0                                                                                    
  ├─isw_djfjjgcbic_Volume0p1  ntfs            Зарезервировано системой 9278093C78092119                    
  ├─isw_djfjjgcbic_Volume0p2  ntfs                                     D2160B4F160B33CF                    
  ├─isw_djfjjgcbic_Volume0p3  ntfs            DATA                     C4DE7C3EDE7C2B36                    
  ├─isw_djfjjgcbic_Volume0p4                                                                                
  └─isw_djfjjgcbic_Volume0p5  ntfs            ACRONIS SZ               45AAFAAAD73AD535                    
sde                           iso9660         Ubuntu 18.04.1 LTS amd64 2018-07-25-03-21-56-00               /cdrom
├─sde1                        iso9660         Ubuntu 18.04.1 LTS amd64 2018-07-25-03-21-56-00              
└─sde2                        vfat            Ubuntu 18.04.1 LTS amd64 0D5F-1DB6                            
root@ubuntu:/home/ubuntu# man dmraid
root@ubuntu:/home/ubuntu# dmraid -ay
RAID set "isw_djbagheehb_VolumeSSD" already active
RAID set "isw_djfjjgcbic_Volume0" already active
RAID set "isw_djfjjgcbic_Volume0p1" already active
RAID set "isw_djfjjgcbic_Volume0p2" already active
RAID set "isw_djfjjgcbic_Volume0p3" already active
RAID set "isw_djfjjgcbic_Volume0p5" already active

```

Check source:

```
mount /dev/mapper/isw_djfjjgcbic_Volume0p2 /mnt/
ls /mnt
```

And clone

```
partclone.ntfs -b -s /dev/mapper/isw_djfjjgcbic_Volume0p2 -o /dev/mapper/isw_djbagheehb_VolumeSSD2
```
