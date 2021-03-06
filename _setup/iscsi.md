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
# doing what you need with virtual sdX disk
service open-iscsi stop
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

## Adding cvl-ubuntu-1604

```
targetcli
cd /backstores/iblock/
```

List existing:

```
/backstores/iblock> ls
o- iblock ................................................... [1 Storage Object]
  o- cvl-ubuntu-1404 .................. [/dev/sysraid/cvl-ubuntu-1404 activated]
```

Create a new one:

```
/backstores/iblock> create cvl-ubuntu-1604 /dev/sysraid/cvl-ubuntu-1604
Generating a wwn serial.
Created iblock storage object cvl-ubuntu-1604 using /dev/sysraid/cvl-ubuntu-1604.
Entering new node /backstores/iblock/cvl-ubuntu-1604
```

Create a LUN:

```
/backstores/i...l-ubuntu-1604> cd /iscsi/iqn.2003-01.org.linux-iscsi.zeus.x8664:sn.a7bb98598ce0/tpgt1/luns/
/iscsi/iqn.20...e0/tpgt1/luns> ls
o- luns ................................................................ [1 LUN]
  o- lun0 .............. [iblock/cvl-ubuntu-1404 (/dev/sysraid/cvl-ubuntu-1404)]
/iscsi/iqn.20...e0/tpgt1/luns> create /backstores/iblock/cvl-ubuntu-1604 
Selected LUN 1.
Successfully created LUN 1.
Entering new node /iscsi/iqn.2003-01.org.linux-iscsi.zeus.x8664:sn.a7bb98598ce0/tpgt1/luns/lun1
```

Disable auth (skipping, already setuped early):

Create a portal(skipping, already setuped early):

Save config and Exit:

```
/iscsi/iqn.20...tpgt1/portals> cd /
/> saveconfig 
WARNING: Saving zeus current configuration to disk will overwrite your boot settings.
The current target configuration will become the default boot config.
Are you sure? Type 'yes': yes
Making backup of srpt/ConfigFS with timestamp: 2016-06-03_15:20:38.394566
Successfully updated default config /etc/target/srpt_start.sh
Making backup of qla2xxx/ConfigFS with timestamp: 2016-06-03_15:20:38.394566
Successfully updated default config /etc/target/qla2xxx_start.sh
Making backup of loopback/ConfigFS with timestamp: 2016-06-03_15:20:38.394566
Successfully updated default config /etc/target/loopback_start.sh
Making backup of fc/ConfigFS with timestamp: 2016-06-03_15:20:38.394566
Successfully updated default config /etc/target/fc_start.sh
Making backup of LIO-Target/ConfigFS with timestamp: 2016-06-03_15:20:38.394566
Generated LIO-Target config: /etc/target/backup/lio_backup-2016-06-03_15:20:38.394566.sh
Making backup of Target_Core_Mod/ConfigFS with timestamp: 2016-06-03_15:20:38.394566
Generated Target_Core_Mod config: /etc/target/backup/tcm_backup-2016-06-03_15:20:38.394566.sh
Successfully updated default config /etc/target/lio_start.sh
Successfully updated default config /etc/target/tcm_start.sh
```
## Note aboout write protected devices:

You can see that LUNs on target is not write protected (`readonly: 0` and `readonly: 0`):

But something is brokes write access when we connected to target and tries to copy partitions.

```
root@zeus:/# service target status
[---------------------------] TCM/ConfigFS Status [----------------------------]
\------> iblock_1
	HBA Index: 2 plugin: iblock version: v4.1.0
        \-------> cvl-ubuntu-1604
        Status: ACTIVATED  Max Queue Depth: 128  SectorSize: 512  HwMaxSectors: 65528
        iBlock device: dm-14  UDEV PATH: /dev/sysraid/cvl-ubuntu-1604  readonly: 0
        Major: 252 Minor: 14  CLAIMED: IBLOCK
        udev_path: /dev/sysraid/cvl-ubuntu-1604
\------> iblock_0
	HBA Index: 1 plugin: iblock version: v4.1.0
        \-------> cvl-ubuntu-1404
        Status: ACTIVATED  Max Queue Depth: 128  SectorSize: 512  HwMaxSectors: 65528
        iBlock device: dm-9  UDEV PATH: /dev/sysraid/cvl-ubuntu-1404  readonly: 0
        Major: 252 Minor: 9  CLAIMED: IBLOCK
        udev_path: /dev/sysraid/cvl-ubuntu-1404

[---------------------------] LIO-Target Status [----------------------------]
\------> iqn.2003-01.org.linux-iscsi.zeus.x8664:sn.99aebb092056
        \-------> tpgt_1  TargetAlias: LIO Target
         TPG Status: ENABLED
         TPG Network Portals:
                 \-------> 192.168.128.2:3260
         TPG Logical Units:
                 \-------> lun_0/a9483fb9f4 -> target/core/iblock_0/cvl-ubuntu-1404
                 \-------> lun_1/0f652582b5 -> target/core/iblock_1/cvl-ubuntu-1604

Target Engine Core ConfigFS Infrastructure v4.1.0 on Linux/x86_64 on 3.13.0-93-generic
Datera Inc. iSCSI Target v4.1.0
```

You must disable parameter `demo_mode_write_protect`, which default value is 1 (enabled)

```
/iscsi/iqn.20...b092056/tpgt1> get attribute demo_mode_write_protect
demo_mode_write_protect=1 

/iscsi/iqn.20...b092056/tpgt1> set attribute demo_mode_write_protect=0
Parameter demo_mode_write_protect is now '0'.

/iscsi/iqn.20...b092056/tpgt1> cd /
/> saveconfig 
```

Prooflink - official documentation: http://linux-iscsi.org/wiki/ISCSI
