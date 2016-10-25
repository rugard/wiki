# Backup existing server

```
knife backup export cookbooks roles environments -D ~/.chef/chef.backup
```

or may be use **`knife download`** - ???.

Try it next time.

# Create a container

```bash
lxc init ubuntu/trusty/amd64 chef
lxc start chef
lxc exec chef bash
```
Configure network:

Setup interfaces:

```
# The primary network interface
#auto eth0
#iface eth0 inet dhcp

auto eth0
iface eth0 inet static
        address 192.168.128.4
        netmask 255.255.255.0
        gateway 192.168.128.1

        dns-search cvision.lab
        dns-nameservers 192.168.128.3
```

Setup fqdn:

> We do not use `chef.cvisionlab.com` as fqdn, because knife solo does not work, when node fqdn resolves to another than chef server ip (i.e. in gate ip)

> I already setuped resolving external name `chef.cvisionlab.com` on dns server and it resolves to internal gateway ip `192.168.128.1`. Chef server is immediately available with manage console.

```
127.0.0.1   localhost
192.168.128.4 chef.cvision.lab chef

# The following lines are desirable for IPv6 capable hosts
::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
```

Setup `/etc/inputrc`.

Setup NOPASSWD:

```bash
root@chef:/home/srvadm# grep NOP /etc/sudoers
%sudo	ALL=(ALL:ALL) NOPASSWD:ALL
```

Reboot:

```bash
reboot
```

Setup server admin:

```bash
lxc exec chef bash

deluser ubuntu
adduser srvadm
usermod -aG sudo srvadm

```

Check resolving, and ssh server:

```bash
apt-get update
apt-get -yq install dnsutils ssh

root@chef:~# nslookup mimas
Server:		192.168.128.3
Address:	192.168.128.3#53

Name:	mimas.cvision.lab
Address: 192.168.128.68

root@chef:~# hostname -f
chef.cvisionlab.com

```



Copy keys:

```bash
skubriev@mimas$ ssh-copy-id srvadm@chef.cvision.lab
```

Publish:

```
lxc image delete chef/bootstrapped
lxc publish chef --alias=chef/clean --force
```

## Bootstrap server

Prepare:

```
knife solo bootstrap srvadm@chef.cvision.lab

# or selective, first install chef, and then cook:
knife solo prepare srvadm@chef.cvision.lab
knife solo cook srvadm@chef.cvision.lab
```

## Initial configuration 

> https://docs.chef.io/install_server.html#standalone

Login to you server and disable history:

```bash
$ ssh srvadm@chef.cvision.lab

# become a root
$ sudo su

```

### Create initial user, be sure you place space before start commands, for 

```bash
# disable bash history
$ set +o history

# USAGE: knife opc user create USERNAME FIRST_NAME [MIDDLE_NAME] LAST_NAME EMAIL PASSWORD
# user=skubriev; chef-server-ctl user-create $user Vladimir Skubriev $user@cvisionlab.com 'password'--filename $user.pem 

# enable history
$ set -o history
```

Save a private key.

```
scp /tmp/skubriev.pem skubriev@mimas:.chef/skubriev.pem
```

Encrypt a pem file on admin machine(**currently not supported by knife**):

> https://discourse.chef.io/t/using-ssh-agent-with-encrypted-knife-client-key/9723

```
# Be ready to enter a good password protection passphrase, below:
user="skubriev"; openssl rsa -aes256 -in ~/.chef/$user.key -out ~/.chef/$user.key
chmod 600  ~/.chef/$user.pem

```


### Create an org.

```bash
chef-server-ctl org-create cvisionlab 'CVisionLab' --association_user skubriev --filename /tmp/cvl-validator.pem
```

Save a private validation key.

```
scp /tmp/cvl-validator.pem skubriev@mimas:.chef/cvl-validator.pem
```

Then you will be able to login with manage console and manage you org.

## Restore server data

Cookbooks:

```
knife backup restore cookbooks -D ~/.chef/chef.backup
knife backup restore environments -D ~/.chef/chef.backup
knife backup restore roles -D ~/.chef/chef.backup
knife backup restore nodes -D ~/.chef/chef.backup
```

**Attention**

This will overwrite existing clients on server !!! 

```
knife backup restore clients -D ~/.chef/chef.backup
```

Creating databags and item's:

```
cd ~/chef-repo
knife data bag create users
knife data bag from file users data_bags/users/sysadmin.json
```

## Fix acl's of nodes:

```
skubriev@mimas[~/chef-repo][1] $ knife acl bulk add group clients nodes '.*' update,read
The ACL of the following nodes will be modified:

### There arenodes list ...

Are you sure you want to modify the ACL of these nodes?? (Y/N) y

```
## Disable sign up in chef manage web interface.

> There is no additional options for configure manage console via chef-server-cookbook. All options described in documentation are deprecated. There we disabling sign up manually.

Create config `/etc/chef-manage/manage.rb`, with following string

```
disable_sign_up true
```

And reconfigure addon:

```
chef-manage-ctl reconfigure
```

## New method to bootstrap a node without ant validator.pem key.

> Using user(admin) pem key
> Do it from admin machine

> Don't forget
> to change pinned client version on server, see `roles/chef_cvision_lab.json`
> before run client.

```
knife bootstrap chef.cvision.lab -x srvadm --sudo -N chef.cvision.lab
```
