# Known issues and solutions

## Job is waiting on storage

1. Работает только архив каталога.
2. Остальные задания приходиться отменять
3. На следующий день опять все зависает на обычном задании.
4. Конфиги правильные, есть подозрение на сообщения из логов вида ```wants Pool="PdcDataLxc" but have Pool="BaculaCatalog"```
5. Смотрим статус sd и видим, что у него висят два задания, одно из них совсем старое ```2642```
6. Отменяем его и архивирование продолжается в штатном режиме.

```python
*status storage=BackupServerBaculaBackupStorage
Connecting to Storage daemon BackupServerBaculaBackupStorage at backup.cvision.lab:9103

bacula-storage Version: 5.2.5 (26 January 2012) x86_64-pc-linux-gnu ubuntu 12.04
Daemon started 27-Jun-15 10:57. Jobs: run=38, running=1.
 Heap: heap=270,336 smbytes=1,225,374 max_bytes=1,290,218 bufs=5,771 max_bufs=5,773
 Sizes: boffset_t=8 size_t=8 int32_t=4 int64_t=8 mode=0,0

Running Jobs:
Writing: Full Backup job BackupBaculaCatalog JobId=2642 Volume=""
    pool="BaculaCatalog" device="BaculaBackupStorage" (/mnt/bigraid/backups/bacula)
    spooling=0 despooling=0 despool_wait=0
    Files=0 Bytes=0 Bytes/sec=0
    FDSocket closed
Writing: Full Backup job BackupPdcDataLxc JobId=2647 Volume=""
    pool="PdcDataLxc" device="BaculaBackupStorage" (/mnt/bigraid/backups/bacula)
    spooling=0 despooling=0 despool_wait=0
    Files=0 Bytes=0 Bytes/sec=0
    FDSocket closed
====

Jobs waiting to reserve a drive:
   3608 JobId=2647 wants Pool="PdcDataLxc" but have Pool="BaculaCatalog" nreserve=1 on drive "BaculaBackupStorage" (/mnt/bigraid/backups/bacula).
====

```
