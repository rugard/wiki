olcAccess and ...
============

**Как работают правила:**

http://pro-ldap.ru/tr/admin24/access-control.html

Цитата:

> директивы access проверяются в порядке их указания в конфигурационном атрибуте. Slapd останавливает проверку на первом критерии отбора <what>, который соответствует целевой записи и/или атрибуту. Директива access с этим критерием отбора и будет той, по которой slapd будет принимать решение о предоставлении доступа.


**Default rules in 16.04**

```
olcAccess: {0}to attrs=userPassword by self write by anonymous auth by * non
 e
olcAccess: {1}to attrs=shadowLastChange by self write by * read
olcAccess: {2}to * by * read
```

`{0}`, `{1}` - аутентификация пользователей и смена своего пароля самим пользователем. 

`{2}` - открыть доступ всем ко всему на чтение.

Правило из 12.04 `olcAccess: {1}to dn.base="" by * read` идентично тому, что в 16.04 `olcAccess: {2}to * by * read`
Т.е. работают они одинаково.

**My rules**

```
olcAccess: {0}to * by dn.exact=gidNumber=0+uidNumber=0,cn=peercred,cn=extern
 al,cn=auth manage by * break
olcAccess: {1}to * by dn.exact=gidNumber=33+uidNumber=33,cn=peercred,cn=exte
 rnal,cn=auth manage by * break
olcAccess: {2}to *  by dn="cn=skubriev,ou=users,dc=cvision,dc=lab" manage
 by * break
olcAccess: {3}to attrs=userPassword by self write by anonymous auth by * non
 e
olcAccess: {4}to attrs=shadowLastChange by self write by * read
olcAccess: {5}to dn.subtree="cn=CVISION.LAB,dc=cvision,dc=lab" by * none
olcAccess: {6}to * by * read
```

Так как мне нужно было запретить доступ к dn `cn=CVISION.LAB,dc=cvision,dc=lab`, мне пришлось вставить правило перед `{6}`
Тот кто авторизовался ранее `{5}` правила, например root или пользователь с gid=33 получит доступ ко всему. И это ограничение его не коснеться.
