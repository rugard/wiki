# Pinning packages in ubuntu

We want to install lxc from trusty-backports. This packages has priority 100 by default.

Then this packages cannot be installed (upgraded) by default.
It's priority (100) less than default branches like `main mulriverse universe restricted`

We can see this by:

```bash
$ apt-cache policy | less
```

Therefore we need to install newer version of lxc with their dependencies, but install only dependencies from backports.
We don't want to install all from backports (upgrade from backports by default all system packages).

Then we create pin file `/etc/apt/preferences.d/lxc`, like so:

```
Package: lxc
Pin: release a=trusty-backports
Pin-Priority: 600

Package: *
Pin: release a=trusty-backports
Pin-Priority: 500
```

For quate backports packages priority to default system packages.
Then the system will see newer versions and upgrade packages automatic.

And upgrade system:

```bash
root@mimas:/home/skubriev# apt-get upgrade 
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
