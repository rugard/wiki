# Mount windows software raid in linux (dualboot system)

http://askubuntu.com/questions/567432/how-do-i-properly-access-windows-software-raid-0

http://stackoverflow.com/questions/8427372/windows-spanned-disks-ldm-restoration-with-linux/22108676#22108676

```
$ sudo apt-get install ldmtool
```

The linked post includes a suggestion for doing this automatically every boot. 

Just open the file ```/etc/init/mountall.conf```

and add the line 

```
[ -x /usr/bin/ldmtool ] && ldmtool create all >/dev/null || true
```

immediately before the exec mountall ... line near the end of the file.

Reboot the system

```
sudo reboot
```
