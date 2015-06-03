



How to restore from bacula without catalog, only from 

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





