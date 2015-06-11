# Useful finds

```bash
find . -size +50M -print -exec ls -lh {} \;
```

```bash
find ../redmine-1.3.1/ -name "*gemspecs*"
```

```bash
find /var -type d -name "*mysql*"
```

**Поиск по содержимому**

```bash
find /ПУТЬ/ -exec grep -H -n 'что искать' '{}' /dev/null \; -print | awk -F \: '{ print $1" - "$2 }'
```

**поиск по логам по определенному числу.**

```bash
find /var/log/ -type f -exec grep -H -n '^Aug 28.*markup.*' '{}' \;
#find biggest files:
find . -type f -size +5G
```

Find with excluding a dir

```
find . -path ./common -prune -o -name '*openvpn*'
```

> в начале отсекаем -path ./common -prune
> -o - иначе (логическое или), ищем
> -name '*openvpn*'

```bash
find . -name .kitchen.yml -not -path "./storage/*"
```
