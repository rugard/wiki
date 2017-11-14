OOM

https://unix.stackexchange.com/questions/128642/debug-out-of-memory-with-var-log-messages

```
watch -n 1 'ps -eo uname,pid,ppid,nlwp,pcpu,pmem,rss,psr,start_time,tty,time,args | grep [p]inger'
```

```
zcat syslog.* | grep Killed
```

Get processes memory stats when oom was called and sort by mem usage:

> Hint :
> rss Resident memory use (in 4 kB pages)
> total_vm Virtual memory use (in 4 kB pages)

```
zcat /var/log/syslog.*.gz | grep -P '\[\d*\][\s]' | sort -n -k 11
```
You can also add `grep 'Nov 13 04:12:02'` to select only one oom call in specific time period

To convert into Megabytes use following schema:

```
[memvalue]×4096÷1024
```
