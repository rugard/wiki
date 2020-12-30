
Some common debian sec examples

```

apt-get install cruft chkrootkit clamav-daemon

cruft --ignore "/dev /proc /sys /root /home /tmp /usr/share/help /var/lib/docker"
clamscan -ir --exclude-dir=/dev --exclude-dir=/proc --exclude-dir=/run --exclude-dir=/sys /
chkrootkit -q
```
