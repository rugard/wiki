# Creating user

**User identified by password with access from anywhere **

```bash
create user 'look'@'%' identified by '456852';
select * from mysql.user;
grant all on *.* to 'look'@'%';
flush privileges;
```

```
echo "DROP DATABASE IF EXISTS awl_move_$PORT;" | mysql -uroot -p456852
mysql -uroot -p456852 -e 'show databases;'

```

