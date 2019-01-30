Run cmd as admin, go windows/system32

```
c:\Windows\System32>vssadmin.exe Delete ShadowStorage /For=x:


X:\>diskshadow
DISKSHADOW> delete shadows all

wbadmin delete catalog

```

Clean logs `c:\Windows\Logs\WindowsServerBackup\`

How to erase old data

The next successful backup will clean up the backups that are no more valid. Windows Server Backup UI reads the backup(s) information from the events logged in the Application channel uder Microsoft\Windows\Backup. If you do not want to see those messages then you need to delete them.

```
sdelete -p 1 -z b:
```

> -p 1 - number of cycles
> -z - clean free space
> b: - disk letter

Also you can use HxD Hex Editor to see what's happened with surface after cleaning it.
