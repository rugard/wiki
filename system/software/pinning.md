# Pinning packages in ubuntu

We want to install lxc from trusty-backports. This packages has priority 100 by default. System packages from `main mulriverse universe restricted` branches has 500 priority in default configuration.

We can see this by:

```bash
$ apt-cache policy | less
```

As we need only to upgrade such packages, like `lxc` but with their dependencies, we need to create two pin rules.

We shouldn't upgrade all system packages with their newer versions from backports branch.

To achieve this we create pin file `/etc/apt/preferences.d/lxc`, like so:

```
Package: lxc
Pin: release a=trusty-backports
Pin-Priority: 600

Package: *
Pin: release a=trusty-backports
Pin-Priority: 500
```

For quate backports packages to default(500) system packages priority.

Then the system will see newer versions and upgrade packages automatic.

Upgrade system:

```bash
$ sudo apt-get upgrade 
Reading package lists... Done
Building dependency tree       
Reading state information... Done
Calculating upgrade... Done
The following packages have been kept back:
  golang golang-go golang-go-linux-amd64 lxc-templates
The following packages will be upgraded:
  cgmanager flex golang-doc golang-src libcgmanager0 libcgmanager0:i386
  libfl-dev liblxc1 libseccomp2 lxc python3-lxc screen squid-deb-proxy-client
  unity-tweak-tool yelp-xsl
15 upgraded, 0 newly installed, 0 to remove and 4 not upgraded.
Need to get 9,372 kB of archives.
After this operation, 6,057 kB of additional disk space will be used.
```

Install lxd:

```bash
$ sudo apt-get install lxd
```
