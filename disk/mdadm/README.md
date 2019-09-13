## writemostly

Set `writemostly` to lowest speed disk in array:

```
root@uranus:/home/srvadm# echo writemostly > /sys/block/md1/md/dev-sdd1/state 
root@uranus:/home/srvadm# cat /sys/block/md1/md/dev-sdd1/state 
in_sync,write_mostly
```

## Select a proper mdadm array type/layout.

**Common for nested related to complex:**

   pros:
   
     * has more clean (not complicated) configuration than complex arrays
   
   cons:
   
     * requires an even number of component devices
     * perfomance cannot be increased

**Common for complex related to nested:**

   pros:
   
     * mdadm has built-in procedure to convert existing raid 1 to raid 10 throught converting raid 1 to raid 0, then we should create level 10 array and should add to it all other disks. (there are versions that does not support growing to level 10, e.g. mdadm on ZEUS (3.2.5-1ubuntu0.3) ) See latest 
     * managed as a single RAID device
     * perfomance can be increased by increasing number of drives (the far layout provides sequential read throughput that scales by number of drives, rather than number of RAID 1 pairs)
     * a single spare can service all component devices


**Maximum performances over single-disk mode should be:**

0. nested 01 (unreliable - never use)

1. nested 10

* 2x sequential read speed (sequential read access can be striped only over disks with different data)
* 2x sequential write speed (while writes can engage all four disks, remember that two disks are in RAID1 fashion)
* 4x random read speed (random read are bound to the number of active spindles, four in this example)
* 2x random write speed (again, writes need to be replicated).

2. complex array with near layout is similar as nested (performance similar too)

* 2x sequential read speed (sequential read access can be striped only over disks with different data)
* 2x sequential write speed (while writes can engage all four disks, remember that two disks are in RAID1 fashion)
* 4x random read speed (random read are bound to the number of active spindles, four in this example)
* 2x random write speed (again, writes need to be replicated).

3. complex array with far layout

* 4x sequential read
* 2x sequential write
* 4x random read
* 2x random write

   pros:
   
     * has better performance than near
     
   cons:
   
     * in random write and mixed random read/write workloads the disks will spend much more time in seeking 

4. complex array with offset

* 4x sequential read
* 2x sequential write
* 4x random read
* 2x random write

   pros:
   
     * seek time is greatly reduced compared to the standard far layout
     
   cons: 
   
     * have slightly lower reliability then near of far layouts

5. complex array with near=2, far=2

Is an artifact of the implementation and is unlikely to be of real value.



Useful links:

https://www.suse.com/documentation/sles11/stor_admin/data/raidmdadmr10cpx.html
http://www.ilsistemista.net/index.php/linux-a-unix/35-linux-software-raid-10-layouts-performance-near-far-and-offset-benchmark-analysis.html?start=1
https://serverfault.com/questions/221778/raid-10-how-layout-works/221782#221782
https://superuser.com/questions/311570/adding-drives-to-a-raid-10-array
https://www.berthon.eu/2017/converting-raid1-to-raid10-online/

Useful manuals: 

```
man 5 mdadm
man 4 md
```


## Увеличение размера массива за счет новых - больших дисков

https://zedt.eu/tech/linux/migrating-existing-raid1-volumes-bigger-drives/

Я делал всё без изменения битмапов.



### Copy part table (GPT) from one to another disk:

https://askubuntu.com/questions/57908/how-can-i-quickly-copy-a-gpt-partition-scheme-from-one-hard-drive-to-another

The first command copies the partition table of sdX to sdY (be careful not to mix these up). The second command randomizes the GUID on the disk and all the partitions. This is only necessary if the disks are to be used in the same machine, 
otherwise it's unnecessary.

```
sgdisk /dev/sdX -R /dev/sdY 
sgdisk -G /dev/sdY
```

## Сервер не загружается после отключения третьего архивного диска

В 16.04 пишут апдейта нет, поидее не должен грузиться с разбитых дисков.

https://bugs.launchpad.net/ubuntu/+source/mdadm/+bug/1635049

Узнал о новом варианте сборки в initrd одной командой, но не проверял:

> https://askubuntu.com/questions/789953/how-to-enable-degraded-raid1-boot-in-16-04lts

```
mdadm -IRs
```

The S labels means the disk is regarded as "spare". You should try stopping and re-starting the array:

```
mdadm --stop /dev/md3
mdadm --stop /dev/md4
mdadm -A --scan
```

или если загрузились с флэшки в recovery mode:

```
mdadm --stop /dev/md126
mdadm --stop /dev/md127
mdadm -A --scan
```

Далее нужно изменить размер массивов:

```
mdadm /dev/md3 -G -n 2 --force
mdadm /dev/md4 -G -n 2 --force
```

И после перезагрузки сервер нормально загрузится.

## Информация о массиве

```bash
mdadm -Q --detail  /dev/md0

mdadm -Avfs
```

## Check and mail
```
mdadm --monitor --scan --test --oneshot
```

### Re-add a faulty disk to rebuild array after i/o error

> -r - removes disk
> -a - add disk 
```
mdadm /dev/md4 -r /dev/sdc1 -a /dev/sdc1
```

## Remove `--quiet` in `/etc/cron.d/mdadm`
## Replace `--idle` with `--slow`



