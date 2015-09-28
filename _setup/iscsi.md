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
exit
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
