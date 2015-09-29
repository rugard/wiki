# Using LIO

> ietd is deprecated
> http://serverfault.com/questions/718290/automatically-build-kernel-modules-after-unattended-upgrades-in-ubuntu

```
apt-get install --no-install-recommends targetcli
targetcli
```

```
/backstores/iblock create cvl-ubuntu-1404 /dev/sysraid/cvl-ubuntu-1404
cd /iscsi
create
```

You will see:

```
Created target iqn.2003-01.org.linux-iscsi.zeus.x8664:sn.c98254f34a49.
Selected TPG Tag 1.
Successfully created TPG 1.
Entering new node /iscsi/iqn.2003-01.org.linux-iscsi.zeus.x8664:sn.c98254f34a49/tpgt1
```

```
cd /iscsi/iqn.2003-01.org.linux-iscsi.zeus.x8664:sn.c98254f34a49/tpgt1/luns
create /backstores/iblock/cvl-ubuntu-1404
Selected LUN 0.
Successfully created LUN 0.
Entering new node /iscsi/iqn.2003-01.org.linux-iscsi.zeus.x8664:sn.c98254f34a49/tpgt1/luns/lun0
```

Disabale auth:

```
cd /iscsi/iqn.2003-01.org.linux-iscsi.zeus.x8664:sn.c98254f34a49/tpgt1/
set attribute authentication=0
set attribute generate_node_acls=1
```

Create a portal 

```
cd /iscsi/iqn.2003-01.org.linux-iscsi.zeus.x8664:sn.c98254f34a49/tpgt1/portals
create ip_address=192.168.128.2
Using default IP port 3260
Successfully created network portal 192.168.128.2:3260.
Entering new node /iscsi/iqn.2003-01.org.linux-iscsi.zeus.x8664:sn.c98254f34a49/tpgt1/portals/192.168.128.2:3260
```

Exit and save config:

```
cd /

/> saveconfig
WARNING: Saving zeus current configuration to disk will overwrite your boot settings.
The current target configuration will become the default boot config.
Are you sure? Type 'yes': yes

exit
```

```
service target restart
service target status

root@zeus:/home/sysadmin# service target status
[---------------------------] TCM/ConfigFS Status [----------------------------]
\------> iblock_0
	HBA Index: 1 plugin: iblock version: v4.1.0
        \-------> cvl-ubuntu-1404
        Status: ACTIVATED  Max Queue Depth: 128  SectorSize: 512  HwMaxSectors: 65528
        iBlock device: dm-10  UDEV PATH: /dev/sysraid/cvl-ubuntu-1404  readonly: 0
        Major: 252 Minor: 10  CLAIMED: IBLOCK
        udev_path: /dev/sysraid/cvl-ubuntu-1404

[---------------------------] LIO-Target Status [----------------------------]
\------> iqn.2003-01.org.linux-iscsi.zeus.x8664:sn.a7bb98598ce0
        \-------> tpgt_1  TargetAlias: LIO Target
         TPG Status: ENABLED
         TPG Network Portals:
                 \-------> 192.168.128.2:3260
         TPG Logical Units:
                 \-------> lun_0/0b660b9e06 -> target/core/iblock_0/cvl-ubuntu-1404

Target Engine Core ConfigFS Infrastructure v4.1.0 on Linux/x86_64 on 3.13.0-62-generic
Datera Inc. iSCSI Target v4.1.0
```

Please do not pay attention to the different iqn's and serials.

# test connection with server on 14.04

```
apt-get install open-iscsi
iscsiadm -m discovery -t st -p zeus
iscsiadm -m node -l
```

# fix iscsi server after kernel upgrade

>
>root@zeus:/mnt/pdc/etc/dhcp# service iscsitarget start
> * Starting iSCSI enterprise target service                                                                        
> FATAL: Module iscsi_trgt not found.

```
apt-get install linux-headers-`uname -r`
apt-get install --reinstall iscsitarget-dkms
service iscsitarget start
```
