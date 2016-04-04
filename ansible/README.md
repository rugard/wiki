# ansible


### How to see variables, run setup on nodes

```
ansible -vvvv ntp_servers -m setup | less


ansible ntp_servers -m setup | less
ansible ntp_clients -m setup | less
ansible ntp -m setup | less
```

### Run a playbook

```
# only show hosts
$ ansible-playbook servers.yml --list-hosts

# run
$ ansible-playbook servers.yml
```


### Writing and test modules:

**Preparing**

```
git clone git://github.com/ansible/ansible.git --recursive
cd ansible
source ansible/hacking/env-setup
chmod +x ansible/hacking/test-module
```

**Testing**

```
ansible/hacking/test-module -m ansible-ntp-for-move/roles/ntp/library/ntptest.py

ansible/hacking/test-module -m ansible-ntp-for-move/roles/ntp/library/ntptest.py -a "max_offset=\"0.2\""

ansible/hacking/test-module -m ansible-ntp-for-move/roles/ntp/library/ntptest.py -a "max_offset=\"0.2\" server=\"192.168.128.42\""
```
