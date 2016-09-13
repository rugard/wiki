# Manage system packages

**Setting up sources.list**

New style with local mirror:

**xenial**

> `extras` is removed in 16.04

```
deb http://security.ubuntu.com/ubuntu xenial-security main restricted universe multiverse
deb http://archive.canonical.com/ubuntu xenial partner
deb mirror://mirror.cvision.lab/mirrors.txt xenial main restricted universe multiverse
deb mirror://mirror.cvision.lab/mirrors.txt xenial-updates main restricted universe multiverse
deb mirror://mirror.cvision.lab/mirrors.txt xenial-backports main restricted universe multiverse
deb mirror://mirror.cvision.lab/mirrors.txt xenial-proposed main restricted universe multiverse

deb-src http://security.ubuntu.com/ubuntu xenial-security main restricted universe multiverse

deb-src http://archive.canonical.com/ubuntu xenial partner

deb-src mirror://mirrors.ubuntu.com/mirrors.txt xenial main restricted universe multiverse
deb-src mirror://mirrors.ubuntu.com/mirrors.txt xenial-updates main restricted universe multiverse
deb-src mirror://mirrors.ubuntu.com/mirrors.txt xenial-proposed main restricted universe multiverse
deb-src mirror://mirrors.ubuntu.com/mirrors.txt xenial-backports main restricted universe multiverse
```

**trusty**

```
deb http://security.ubuntu.com/ubuntu trusty-security main restricted universe multiverse
deb http://archive.canonical.com/ubuntu trusty partner
deb http://extras.ubuntu.com/ubuntu trusty main
deb mirror://mirror.cvision.lab/mirrors.txt trusty main restricted universe multiverse
deb mirror://mirror.cvision.lab/mirrors.txt trusty-updates main restricted universe multiverse
deb mirror://mirror.cvision.lab/mirrors.txt trusty-backports main restricted universe multiverse
deb mirror://mirror.cvision.lab/mirrors.txt trusty-proposed main restricted universe multiverse

deb-src http://security.ubuntu.com/ubuntu trusty-security main restricted universe multiverse

deb-src http://archive.canonical.com/ubuntu trusty partner
deb-src http://extras.ubuntu.com/ubuntu trusty main

deb-src mirror://mirrors.ubuntu.com/mirrors.txt trusty main restricted universe multiverse
deb-src mirror://mirrors.ubuntu.com/mirrors.txt trusty-updates main restricted universe multiverse
deb-src mirror://mirrors.ubuntu.com/mirrors.txt trusty-proposed main restricted universe multiverse
deb-src mirror://mirrors.ubuntu.com/mirrors.txt trusty-backports main restricted universe multiverse
```

**precise**
```
deb http://security.ubuntu.com/ubuntu precise-security main restricted universe multiverse
deb http://archive.canonical.com/ubuntu precise partner
deb http://extras.ubuntu.com/ubuntu precise main
deb mirror://mirror.cvision.lab/mirrors.txt precise main restricted universe multiverse
deb mirror://mirror.cvision.lab/mirrors.txt precise-updates main restricted universe multiverse
deb mirror://mirror.cvision.lab/mirrors.txt precise-backports main restricted universe multiverse
deb mirror://mirror.cvision.lab/mirrors.txt precise-proposed main restricted universe multiverse

deb-src http://security.ubuntu.com/ubuntu precise-security main restricted universe multiverse
deb-src http://archive.canonical.com/ubuntu precise partner
deb-src http://extras.ubuntu.com/ubuntu precise main
deb-src mirror://mirrors.ubuntu.com/mirrors.txt precise main restricted universe multiverse
deb-src mirror://mirrors.ubuntu.com/mirrors.txt precise-updates main restricted universe multiverse
deb-src mirror://mirrors.ubuntu.com/mirrors.txt precise-proposed main restricted universe multiverse
deb-src mirror://mirrors.ubuntu.com/mirrors.txt precise-backports main restricted universe multiverse

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

**Ubuntu branches**

Following: http://unix.stackexchange.com/questions/185588/whats-the-diffrence-between-the-various-ubuntu-repository-branches

The repository components are:

**Main** - Officially supported software.
**Restricted** - Supported software that is not available under a completely free license.
**Universe** - Community maintained software, i.e. not officially supported software.
**Multiverse** - Software that is not free.


**"Important Security Updates (raring-security)".** Patches for security vulnerabilities in Ubuntu packages. They are managed by the Ubuntu Security Team and are designed to change the behavior of the package as little as possible -- in fact, the minimum required to resolve the security problem. As a result, they tend to be very low-risk to apply and all users are urged to apply security updates.

**"Recommended Updates (raring-updates)".** Updates for serious bugs in Ubuntu packaging that do not affect the security of the system.

**"Pre-released Updates (raring-proposed)".** The testing area for updates. This repository is recommended only to those interested in helping to test updates and provide feedback.

**"Unsupported Updates (raring-backports)".** As the name states, these are unsupported new versions of packages which have been backported to an older release. Packages may contain new features, may introduce new interfaces, and bugs.

For more information on backports, visit UbuntuBackports
```

**Clean packages list cache**

```bash
$ sudo rm -r /var/cache/apt /var/lib/apt/lists
$ sudo apt-get update #takes a while re-fetching everything
$ sudo apt-get install <some-random-package>
```

Following: http://serverfault.com/questions/368669/debian-ubuntu-is-it-possible-to-reinitialize-var-lib-apt-lists-and-var-apt-cac

**Fix GPG error on ubuntu 12.04 machines**

Error Text:
```
W: GPG error: http://extras.ubuntu.com precise Release: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY 16126D3A3E5C1192
```

Following: http://askubuntu.com/questions/131601/how-to-overcome-signature-verification-error

```bash
# gpg --keyserver hkp://subkeys.pgp.net --recv-keys 16126D3A3E5C1192
# gpg --export --armor 16126D3A3E5C1192 | sudo apt-key add -
# apt-get update

```


## Install only security upgrades

```bash
unattended-upgrade --dry-run -d
or
sudo apt-get -s dist-upgrade | grep "^Inst" | grep -i securi | awk -F " " {'print $2'} | xargs sudo apt-get -y -q install
```


