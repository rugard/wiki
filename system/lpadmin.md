# How to make setup command for home hp printer:

**How to uri (for -v option):**

```
$ hp-makeuri 192.168.104.100
```

**How to get driver name (for -m option):**
```
$ lpinfo -m | grep 1214
```

Add a printer to the system

> `hplip:0/ppd/hplip/HP/hp-laserjet_professional_m1214nfh_mfp-hpijs.ppd` - not work last time
> use `drv:///hpcups.drv/hp-laserjet_professional_m1214nfh_mfp.ppd`
> scan works with both driver

```
$ sudo lpadmin -E -p hp1214_cabinet \
-v "socket://192.168.104.100" \
-v "hp:/net/HP_LaserJet_Professional_M1214nfh_MFP?ip=192.168.104.100" \
-L "cabinet" \
-m drv:///hpcups.drv/hp-laserjet_professional_m1214nfh_mfp.ppd \
-E
```

**Don't forget to setup `sudo hp-plugin` for scan to work**
