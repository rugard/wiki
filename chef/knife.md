# Chef, knife and other devops automation tools related to chef software

## Using knife

**Bootstrap a new client/node **

```
knife bootstrap --sudo -x wsadm -N shuttle.cvision.lab shuttle.cvision.lab
Node shuttle.cvision.lab exists, overwrite it? (Y/N) y
Client shuttle.cvision.lab exists, overwrite it? (Y/N) y
Creating new client for shuttle.cvision.lab
Creating new node for shuttle.cvision.lab
Connecting to shuttle.cvision.lab
shuttle.cvision.lab knife sudo password: 
Enter your password: 
shuttle.cvision.lab 
shuttle.cvision.lab -----> Installing Chef Omnibus (-v 12)
```

Method 2:

```
knife bootstrap --bootstrap-version "12.19.36" --sudo -x wsadm -N xenial.cvision.lab 192.168.129.220
```

**Show differences beetween repo and server**

```bash
# alias kd='knife diff'
knife diff
```

**Show only names, and static for just roles, environments, cookbooks, and data bags.**

```
# alias kdonrms='knife diff --name-only --repo-mode static'
knife diff --name-only --repo-mode static
```
> environments/_default.json is always will showing, because it is to be exist on the chef server always, it is read only object.

**Upload updated roles**

```
export modified=$(knife diff --name-only)
for role in $modified; do printf "ROLE $role\n"; knife role from file $role; printf "\n"; done
```

**Edit node config in the server**

```bash
knife node edit zeus.cvision.lab
```

**View merged node attribute value, stored on the server**

```bash
knife node show zeus.cvision.lab -a postfix.main.mydestination
```

**Add self-signed certificate to trusted on the chef-client**

See http://jtimberman.housepub.org/blog/2014/12/11/chef-12-fix-untrusted-self-sign-certs/

new note (only one command)

> If you have old chef 11-x version, you may need to update chef-client (for ssl command) via omnibus, before `knife ssl fetch`
> curl -L https://omnitruck.chef.io/install.sh | sudo bash

```
knife ssl fetch -s "https://chef.cvision.lab:443" -c /etc/chef/client.rb
```

old note

```bash
knife ssl fetch https://chef.cvision.lab -c /etc/chef/client.rb
sudo mkdir /etc/chef/trusted_certs
sudo cp /home/skubriev/.chef/trusted_certs/chef_cvision_lab.crt /etc/chef/trusted_certs/
```


**Upload a databag to server from chef-repo**

```
skubriev@mimas:~/chef-repo/data_bags$ knife data bag from file users users/sysadmin.json 
Updated data_bag_item[users::sysadmin]
```

**Set node run_list and default environment** 

Useful after boostrap a node

```bash
knife node run_list add ganymede.cvision.lab 'role[ganymede_cvision_lab]'
knife node environment_set ganymede.cvision.lab cvisionlab
...
knife node run_list add redmine-dev.cvision.lab 'recipe[csquiddebproxy],recipe[apt],recipe[initialubuntu],recipe[ntp::ntpdate],credmine'
```

**Search node's by system version**

```bash
knife search node 'platform_version:12.04' -i
```

**Backup and Delete all cookbooks from server**

Backup

```
sudo chef gem install knife-backup
knife backup export cookbooks -D Backups/chef-server-cookbooks-before-berks3
```

Delete

```bash
skubriev@mimas:~/chef-repo$ knife cookbook bulk delete ".*" -p

All versions of the following cookbooks will be deleted:

apache2               dc                    openssl
apt                   dpkg_autostart        openvpn
aws                   fail2ban              perl
...
```

**knife ssh**

Run a chef-client on nodes


```bash
knife ssh "roles:default_desktop_1404_rnd" "sudo chef-client" -i ~/.ssh/id_rsa -x sysadmin --no-host-key-verify
```

```bash
knife ssh "roles:default_server" "sudo chef-client>/dev/null;echo $?" -i ~/.ssh/id_rsa -x sysadmin --no-host-key-verify
```

```
knife ssh "roles:default_desktop" "sudo chef-client &2>1 1>/dev/null; if [ $? -eq 0 ]; then echo "OK"; else echo "BAD"; fi" -i ~/.ssh/id_rsa -x sysadmin --no-host-key-verify
```

```
knife ssh "*:*" "uptime" -i ~/.ssh/id_rsa.pub -x sysadmin --no-host-key-verify
```

**Inventarization with knife**

```bash
knife ssh "name:mimas.cvision.lab" "free -m > /tmp/hw; sudo hdparm -I /dev/sd[abcd] >> /tmp/hw; cat /proc/cpuinfo | grep -e 'model name' -e 'cpu cores' >> /tmp/hw" -i ~/.ssh/id_rsa -x sysadmin --no-host-key-verify
```

**Using Search**

List all nodes names:

```bash
knife search "*:*" -i
knife search node 'name:*cvision.lab-*' -i
```
## Using chef-vault

Create a vault

```
knife vault create _ldap_cvision_lab srvreporeader '{"password":"srvreporeader_password" }' --admins admin -S name:*.cvision.lab
```

# Knowing ISSUE's

**Bootstrap from chef server error: ERROR: SSL Validation failure connecting to host: chef.cvision.lab**

```bash
root@gate:/home/srvadm# chef-client 
Starting Chef Client, version 12.3.0
Creating a new client identity for gate.cvision.lab using the validator key.
[2015-07-14T15:43:21+03:00] ERROR: SSL Validation failure connecting to host: chef.cvision.lab - SSL_connect returned=1 errno=0 state=SSLv3 read server certificate B: certificate verify failed

================================================================================
Chef encountered an error attempting to create the client "gate.cvision.lab"
================================================================================

[2015-07-14T15:43:21+03:00] FATAL: Stacktrace dumped to /var/chef/cache/chef-stacktrace.out
Chef Client failed. 0 resources updated in 1.733779135 seconds
[2015-07-14T15:43:21+03:00] ERROR: SSL_connect returned=1 errno=0 state=SSLv3 read server certificate B: certificate verify failed
[2015-07-14T15:43:21+03:00] FATAL: Chef::Exceptions::ChildConvergeError: Chef run process exited unsuccessfully (exit code 1)
```

Fix on client:

```
[2015-07-14T15:43:21+03:00] FATAL: Chef::Exceptions::ChildConvergeError: Chef run process exited unsuccessfully (exit code 1)
root@gate# knife ssl fetch -c /etc/chef/client.rb
WARNING: Certificates from chef.cvision.lab will be fetched and placed in your trusted_cert
directory (/etc/chef/trusted_certs).
```

**View cookbook dependencies**

There is no default command to see rdepends of cookbook dependencies.

```bash
#!/bin/bash
pushd public
for cookbook in *
do
  knife deps $cookbook --tree && printf "\n"
done
```

