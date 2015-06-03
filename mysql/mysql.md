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

**Reset mysql root password script:**

```
mysql -u root --password=#{node['mysql']['server_root_password']} mysql -e 'show databases;'> /dev/null
                if ! [ $? -eq 0 ]; then
                    service mysql stop; if ! [ $? -eq 0 ]; then exit 1000; fi;
                    sleep 3
                    mysqld_safe --skip-grant-tables --socket=/tmp/mysqld_safe.socket --pid-file=/tmp/mysqld_safe.pid >/dev/null &
                    echo "use mysql;" > /tmp/mysql_flush_root.sql
                    echo "update user set password=PASSWORD('#{node['mysql']['server_root_password']}') where User='root'; " >> /tmp/mysql_flush_root.sql
                    # Update privileges in memmory, because if we don't do this old password be valied instead of new.
                    echo "flush privileges;" >> /tmp/mysql_flush_root.sql
                    sleep 5
                    mysql --socket=/tmp/mysqld_safe.socket < /tmp/mysql_flush_root.sql
                    rm /tmp/mysql_flush_root.sql
                    kill -TERM $(cat /tmp/mysqld_safe.pid);
                    sleep 2
                    service mysql start
                else exit 0;
                fi

```


