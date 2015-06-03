# All useful regex's

```bash
perl -pe 's/\(.*?\)(, )?//g' /tmp/history.log | sed 's/\s/\n/g'
```

```
cat /var/log/auth.log* | grep 'Failed password' | grep sshd | awk '{print $1,$2}' | sort -k 1,1M -k 2n | uniq -c
```


