## Backup C and other boot critical filesystems

Run cmd as admin !

```
wbadmin start backup -backupTarget:E: -include:c: -allCritical -vssFull
```
