# All useful regex's

3. Я никогда не использую "grep", всегда использую или egrep, или fgrep:
  - fgrep быстрее для фиксированных низов
  - fgrep не интерпретирует специальных символов - ".", "[", "]", "*"...
  - egrep использует немножко поудобнее синтаксис extended regular
    expressions чем grep - не нужно столько \ ставить.

4. Подсовывайте опцию "-e" перед аргументом grep и sed.  Для единичного
   аргумента не очень полезно, но очень будет полезно, когда вздумается
   подавать второй и третий аргумент: fgrep -e exp1 -e ex


```bash
perl -pe 's/\(.*?\)(, )?//g' /tmp/history.log | sed 's/\s/\n/g'
```

```
cat /var/log/auth.log* | grep 'Failed password' | grep sshd | awk '{print $1,$2}' | sort -k 1,1M -k 2n | uniq -c
```

# regex in man pages

>posix regex in man

```
\s*-c.*
\s - space, * - multiple symbols, -c - a parameter, which i want to find
```

# sed -r - with Extended regular expressions

>Символы ‘?’, ‘+’, круглые скобки, {}, должны бать экранированы символом \ если вы хотите использовать их как специальные символы

```bash
sed -r 's/(userPassword:: )(.*)/echo -n "\1"; echo \2 | base64 -d/e' /tmp/passwd
```

100% work
```bash
sed -i -r 's/(BOOT_DEGRADED=)(.*)/echo -n "\1"; echo "true"/e' /etc/initramfs-tools/conf.d/mdadm
```

```bash 
sed -r '/^userPassword/s/^userPassword:: (.*)/ echo "\1" | base64 -d/e' /tmp/passwd
```

Опцию -i нельзя совмещать с другими параметрами он должна идти отдельно т.к. может быть с не обязательным параметром [SUFFIX]

```bash
sed -i -r '/^.*::.*/s/(^.*:: )(.*)/echo -n "\1"; echo \2 | base64 -d/e' /tmp/passwd
```

```bash
cat /etc/dhcp/dhcpd.conf.hosts | grep host | sed -r 's/\s*host\s(.*)\s*\{/\1/'
cat /etc/dhcp/dhcpd.conf.hosts | grep host | sed -r 's/\s*host\s(.*)\s*\{/\1/' | tr -s '\n' ' '
```

**Переименование rename sed **

```bash
for i in *cvision_lab_rb*
do
        # zeus.cvision.lab.rb
        echo $i
        newname=`echo $i | sed -r 's/(.*)\.(.*)\.(.*)\.(.*)/\1_\2_\3\.\4/'`
        mv $i $newname
done
```

OOM Killer stats sorted:

https://unix.stackexchange.com/questions/128642/debug-out-of-memory-with-var-log-messages

> Tested with https://regexr.com/, this site uses Perl regex

> `Nov 13 04:12:02 dione kernel: [842051.716704] [31914]     0 31914  1474538  1099403    2226        0             0 pinger.rb`
> 1099403*4096/1024/1024=4294 Mb
> rss - Resident memory use (in 4 kB pages)

```
grep 'Nov 13 04:12:02' /var/log/syslog | grep -P '\[\d*\][\s]' | sort -n -k 11
```
