


## reset chef server password

http://lists.opscode.com/sympa/arc/chef/2013-03/msg00335.html

```bash
sudo -u opscode-pgsql  /opt/chef-server/embedded/bin/psql opscode_chef
```

```sql
update osc_users set hashed_password = '$2a$12$y31Wno2MKiGXS3FSgVg5UunKG48gJz0pRV//RMy1osDxVbrb0On4W' , salt ='$2a$12$y31Wno2MKiGXS3FSgVg5Uu' where username ='admin';
```

And login with user 'admin' and password 'password', it works now.
