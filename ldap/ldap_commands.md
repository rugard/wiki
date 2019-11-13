## ldap search examples

```bash
ldapsearch -Y EXTERNAL -H ldapi:/// -b ou=users,dc=cvision,dc=lab "(cn=*)" | sed '/^# search result/,$d' | grep -v ^# | less
```

Anonymous bind 

> -x - tells ldapsearch to perform a simple_authentication (yes, you need this even for anonymous bind)

```
ldapsearch -h ldap -x -p 389 -b ou=users,dc=cvision,dc=lab "(cn=*)" | sed '/^# search result/,$d' | grep -v ^# | less
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

test from internet, e.g. htz srvs (Using -H):

```
ldapsearch -v -H ldaps://ldap.cvisionlab.com -x -b ou=users,dc=cvision,dc=lab "(cn=*)"
```


view first raw db:

```bash
less /etc/ldap/slapd.d/cn\=config/olcDatabase\=\{1\}hdb.ldif
```
### remove default anonymous read all entries access:

`remove-anonymous-default-access.ldif:`

```
dn: olcDatabase={1}mdb,cn=config
changetype: modify
delete: olcAccess
olcAccess: {4}
```

```
ldapmodify -Y EXTERNAL -H ldapi:/// -f remove.ldif 
SASL/EXTERNAL authentication started
SASL username: gidNumber=0+uidNumber=0,cn=peercred,cn=external,cn=auth
SASL SSF: 0
modifying entry "olcDatabase={1}mdb,cn=config"
```
