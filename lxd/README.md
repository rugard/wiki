# Using LXD

Install bash_completion profile:

```bash
root# wget https://raw.githubusercontent.com/arges/lxd/master/config/bash/lxc.in -O /etc/bash_completion.d/lxd
```

### Images

```bash
lxc remote add images images.linuxcontainers.org
lxc image list images:
```

### Start a new vm

```
lxc init images:ubuntu/trusty/amd64 trusty
lxc init images:ubuntu/xenial/amd64 xenial
```

### Stop a vm

> --force is used when guest init does not react to SIGPWR

```bash
lxc stop trusty
lxc stop xenial --force
```
