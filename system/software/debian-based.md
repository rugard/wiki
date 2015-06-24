# Manage system packages

**Setting up sources.list**

New style with local mirror:

```
# Security packages are always downloaded from main sites
deb http://security.ubuntu.com/ubuntu trusty-security main restricted universe multiverse
#deb mirror://mirrors.ubuntu.com/mirrors.txt trusty-security main restricted universe multiverse

# Additional branches are not present on most of all mirrors, therefore download it from canonical servers
deb http://archive.canonical.com/ubuntu trusty partner
deb http://extras.ubuntu.com/ubuntu trusty main

# Main branches download from local mirror.
deb mirror://st.cvision.lab/mirrors.txt trusty main restricted universe multiverse
deb mirror://st.cvision.lab/mirrors.txt trusty-updates main restricted universe multiverse
deb mirror://st.cvision.lab/mirrors.txt trusty-backports main restricted universe multiverse
deb mirror://st.cvision.lab/mirrors.txt trusty-proposed main restricted universe multiverse
```

It is difficult to setup additional repos like as partner and extras with http server. I conducted an investigation and found that this repos are not synced at most mirrors. Therefore we don't synchronize them.

Old style:

```
# Binaries
deb http://ru.archive.ubuntu.com/ubuntu/ trusty main restricted universe multiverse
deb http://ru.archive.ubuntu.com/ubuntu/ trusty-updates main restricted universe multiverse
deb http://ru.archive.ubuntu.com/ubuntu/ trusty-backports main restricted universe multiverse
deb http://security.ubuntu.com/ubuntu trusty-security main restricted universe multiverse
deb http://archive.canonical.com/ubuntu trusty partner
deb http://extras.ubuntu.com/ubuntu trusty main

# Sources
deb-src http://ru.archive.ubuntu.com/ubuntu/ trusty main restricted universe multiverse
deb-src http://ru.archive.ubuntu.com/ubuntu/ trusty-updates main restricted universe multiverse
deb-src http://ru.archive.ubuntu.com/ubuntu/ trusty-backports main restricted universe multiverse
deb-src http://security.ubuntu.com/ubuntu trusty-security main restricted universe multiverse
deb-src http://archive.canonical.com/ubuntu trusty partner
deb-src http://extras.ubuntu.com/ubuntu trusty main
```

Only one arch:

```
deb [arch=amd64] mirror://st.cvision.lab/mirrors.txt trusty main restricted universe multiverse
```

> There is no difference beetween mirror and http://security uri's in downloading speed.
> mirror://mirrors.ubuntu.com/mirrors.txt
> real	0m28.792s
> http://security.ubuntu.com/ubuntu
> real	0m28.324s

**Clean packages list cache**

```bash
$ sudo rm -r /var/cache/apt /var/lib/apt/lists
$ sudo apt-get update #takes a while re-fetching everything
$ sudo apt-get install <some-random-package>
```

Following: http://serverfault.com/questions/368669/debian-ubuntu-is-it-possible-to-reinitialize-var-lib-apt-lists-and-var-apt-cac
