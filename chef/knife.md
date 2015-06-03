# Chef, knife and other devops automation tools related to chef software

## Using knife

**Edit node config in the server**

```bash
knife node edit zeus.cvision.lab
```

**View merged node attribute value, stored on the server**

```bash
knife node show zeus.cvision.lab -a postfix.main.mydestination
```

**Add self-signed certificate to trusted on the chef-client**

http://jtimberman.housepub.org/blog/2014/12/11/chef-12-fix-untrusted-self-sign-certs/

```bash
knife ssl fetch https://chef.cvision.lab
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

**Delete all cookbooks from server**

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
knife ssh "roles:default_server" "sudo chef-client>/dev/null;echo $?" -i ~/.ssh/id_rsa -x sysadmin --no-host-key-verify
```

```
knife ssh "roles:default_desktop" "sudo chef-client &2>1 1>/dev/null; if [ $? -eq 0 ]; then echo "OK"; else echo "BAD"; fi" -i ~/.ssh/id_rsa -x sysadmin --no-host-key-verify
```

```
knife ssh "*:*" "uptime" -i ~/.ssh/id_rsa.pub -x sysadmin --no-host-key-verify
```

**invent with knife**

```bash
knife ssh "name:mimas.cvision.lab" "free -m > /tmp/hw; sudo hdparm -I /dev/sd[abcd] >> /tmp/hw; cat /proc/cpuinfo | grep -e 'model name' -e 'cpu cores' >> /tmp/hw" -i ~/.ssh/id_rsa -x sysadmin --no-host-key-verify
```
