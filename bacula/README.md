**View job details**

```
*show job=BackupBaculaCatalog
Job: name=BackupBaculaCatalog JobType=66 level=Full Priority=10 Enabled=1
     MaxJobs=1 Resched=0 Times=0 Interval=1,800 Spool=0 WritePartAfterJob=1
     Accurate=0
  --> Client: name=backup address=backup.cvision.lab FDport=9102 MaxJobs=1
      JobRetention=6 months  FileRetention=2 months  AutoPrune=1
  --> Catalog: name=bacula-catalog address=localhost DBport=0 db_name=bacula
      db_driver=*None* db_user=bacula MutliDBConn=0
  --> FileSet: name=BaculaCatalog
      O M
      N
      I /var/lib/bacula/bacula.sql
      N
  --> Schedule: name=WeeklyCycleAfterAllBackups
  --> Run Level=Full
      hour=6 
      mday=0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 
      month=0 1 2 3 4 5 6 7 8 9 10 11 
      wday=0 1 2 3 4 5 6 
      wom=0 1 2 3 4 
      woy=0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 
      mins=30
  --> Storage: name=BackupServerBaculaBackupStorage address=backup.cvision.lab SDport=9103 MaxJobs=1
      DeviceName=BaculaBackupStorage MediaType=File StorageId=1
 --> RunScript
  --> Command=/etc/bacula/scripts/make_catalog_backup bacula bacula pass backup.cvision.lab
  --> Target=%c
  --> RunOnSuccess=1
  --> RunOnFailure=0
  --> FailJobOnError=1
  --> RunWhen=2
 --> RunScript
  --> Command=rm /var/lib/bacula/bacula.sql
  --> Target=%c
  --> RunOnSuccess=1
  --> RunOnFailure=0
  --> FailJobOnError=1
  --> RunWhen=1
  --> Pool: name=BaculaCatalog PoolType=Backup
      use_cat=1 use_once=1 cat_files=1
      max_vols=30 auto_prune=1 VolRetention=10 mins 
      VolUse=0 secs recycle=1 LabelFormat=BaculaCatalog
      CleaningPrefix=*None* LabelType=0
      RecyleOldest=1 PurgeOldest=0 ActionOnPurge=0
      MaxVolJobs=0 MaxVolFiles=0 MaxVolBytes=0
      MigTime=0 secs MigHiBytes=0 MigLoBytes=0
      JobRetention=0 secs FileRetention=0 secs
  --> Messages: name=Standard
      mailcmd=/bin/bash /usr/local/sbin/customscripts/mail/msmtp-bacula-frontend.sh %i %t %e %c %r %n %l
```

**Test config and reload**

```
# bacula-dir -t -c /etc/bacula/bacula-dir.conf
# service bacula-director reload
```

**View all schedules (not only at 24 hours forward)**

```
*status director days=365
```

**Reset root webacula password**

```!bash
# mysql -uroot -ppass

mysql> use bacula;
mysql> select * from webacula_users;
mysql> delete from webacula_users where login='root';
mysql> INSERT INTO webacula_users (id, login, pwd, name, active, create_login, role_id) VALUES (1000, 'root', '$P$BbbdFp75Mwp5SkxzT114HL2g3jsn1t0', 'root', 1, NOW(), 1);
```

## Additional notes about setup bacula in suntimes:

1. don't forget to add bacula to libvirtd group, for success run virsh shutdown/start

**How to restore from bacula without catalog, only from**

http://pipposan.wordpress.com/2010/06/09/bacula-tape-restore-without-database/

Find latest volume

# bls -j -V BaculaCatalog0045 /mnt/bigraid/backups/bacula
bls: butil.c:287 Using device: "/mnt/bigraid/backups/bacula" for reading.
17-Jan 11:44 bls JobId 0: Ready to read from volume "BaculaCatalog0045" on device "BaculaBackupStorage" (/mnt/bigraid/backups/bacula).
Volume Record: File:blk=0:213 SessId=4 SessTime=1389795845 JobId=0 DataLen=178
Begin Job Session Record: File:blk=0:64725 SessId=4 SessTime=1389795845 JobId=500
   Job=BackupBaculaCatalog.2014-01-16_06.30.00_05 Date=16-Jan-2014 06:31:50 Level=F Type=B
End Job Session Record: File:blk=0:3256011665 SessId=4 SessTime=1389795845 JobId=500
   Date=16-Jan-2014 06:34:27 Level=F Type=B Files=1 Bytes=3,253,598,370 Errors=0 Status=T
17-Jan 11:45 bls JobId 0: End of Volume at file 0 on device "BaculaBackupStorage" (/mnt/bigraid/backups/bacula), Volume "BaculaCatalog0045"
17-Jan 11:45 bls JobId 0: End of all volumes.

Create bsr file! From data of previous bls command 
restore-bacula-catalog.bsr:
Volume = BaculaCatalog0045
VolSessionId = 4
VolSessionTime = 1389795845



# cd /mnt/bigraid/backups/bacula

# bextract -b restore-bacula-catalog.bsr -V /mnt/bigraid/backups/bacula/BaculaCatalog0045 /mnt/bigraid/backups/bacula /mnt/bigraid/

Возможно будет работать и без -V /mnt/bigraid/backups/bacula/BaculaCatalog0045 


# mysql -uroot -pSECRETPASSWORD bacula < /mnt/bigraid/var/lib/bacula/bacula.sql





