# ansible


### How to see variables


```
ansible -vvvv ntp_servers -m setup | less


ansible ntp_servers -m setup | less
ansible ntp_clients -m setup | less
ansible ntp -m setup | less
```
