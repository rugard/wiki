# Creating user

**User identified by password with access from anywhere **

```bash
create user 'look'@'%' identified by '456852';
select * from mysql.user;
grant all on *.* to 'look'@'%';
flush privileges;
```


