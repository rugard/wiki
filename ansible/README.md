# ansible


### How to see variables


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
