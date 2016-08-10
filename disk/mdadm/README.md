## Сервер не загружается после отключения третьего архивного диска

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
