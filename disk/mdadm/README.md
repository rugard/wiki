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
