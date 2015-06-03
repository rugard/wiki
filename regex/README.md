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


