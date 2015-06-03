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

**Set node run_list and default environment 

Useful after boostrap a node

```bash
knife node run_list add ganymede.cvision.lab 'role[ganymede_cvision_lab]'
knife node environment_set ganymede.cvision.lab cvisionlab
```
