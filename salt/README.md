# Using salt stack

## Install salt master

Following official guide:

http://docs.saltstack.com/en/latest/topics/installation/ubuntu.html

### Prepare container host

```bash
lxc-create -t download -n salt -B lvm --lvname=salt --vgname=sysraid --fssize=5120M -- --dist ubuntu --release trusty --arch amd64
```

```
sudo apt-get install python-software-properties software-properties-common 
sudo add-apt-repository ppa:saltstack/salt
sudo apt-get install salt-minion

# on the salt master
salt-key -L
salt-key -A
```
