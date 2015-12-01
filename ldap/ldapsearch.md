## ldap search examples

```bash
ldapsearch -Y EXTERNAL -H ldapi:/// -b ou=users,dc=cvision,dc=lab "(cn=*)" | sed '/^# search result/,$d' | grep -v ^# | less
```
