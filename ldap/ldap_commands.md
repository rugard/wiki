## ldap search examples

```bash
ldapsearch -Y EXTERNAL -H ldapi:/// -b ou=users,dc=cvision,dc=lab "(cn=*)" | sed '/^# search result/,$d' | grep -v ^# | less
```

sssd request for search users

must get users by anonymous bind (on clients where sssd should be installed):

```bash
ldapsearch -h ldap -x -b dc=cvision,dc=lab "(&(objectclass=posixAccount)(uid=*)(uidNumber=*)(gidNumber=*))"
```
otherwise sssd will not found a users. nss doesn't work via `sss` provider

request from ldap server root console:

```bash
ldapsearch -Y EXTERNAL -H ldapi:/// -b dc=cvision,dc=lab "(&(objectclass=posixAccount)(uid=*)(uidNumber=*)(gidNumber=*))"
```

view first raw db:

```bash
less /etc/ldap/slapd.d/cn\=config/olcDatabase\=\{1\}hdb.ldif
```

