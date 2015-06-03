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

```
create database `redmine`;
create user 'rmdbuser'@'localhost' identified by '’;
grant all privileges on redmine.* to 'rmdbuser'@'localhost';
select * from user;
flush privileges;

```

```
SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'bacula' AND table_name LIKE 'webacula%';
SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'bacula' AND table_name NOT LIKE 'webacula%';
SELECT table_name FROM information_schema.tables WHERE table_schema = 'bacula' AND table_name LIKE 'webacula%';
select table_name from information_schema.tables where table_schema = 'bacula';
```

```
PASSWORD - to save hash instead of cleartext !!!
UPDATE mysql.user SET Password=PASSWORD('cleartextpassword') WHERE User='root';
UPDATE mysql.user SET Password=PASSWORD('cleartextpassword') WHERE User='repl';
UPDATE mysql.user SET Password=PASSWORD('cleartextpassword') WHERE User='debian-sys-maint';

flush privileges;
```




```
UPDATE mysql.user SET host='%' WHERE User='root' and host='localhost';
flush privileges;

```

```bash
mysql -u root -p
Password:
select Host,User,Password from mysql.user;
delete from mysql.user where host='192.168.128.68' and user='root';
flush privileges;
```

**Reset mysql root password script:**

Manually:

```bash
/etc/init.d/mysql stop 
mysqld_safe --skip-grant-tables &
mysql -u root
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 1 to server version: 4.1.15-Debian_1-log
Type 'help;' or '\h' for help. Type '\c' to clear the buffer.
mysql>
mysql> use mysql;
mysql> update user set password=PASSWORD("NEW-ROOT-PASSWORD") where User='root';
mysql> flush privileges;
mysql> quit
killall mysqld_safe
killall mysqld_safe
140211 16:15:26 mysqld_safe mysqld from pid file /var/run/mysqld/mysqld.pid ended
```

From chef cookbook redmine:

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


