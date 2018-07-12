# Installing latest mainline kernel in 18.04

Go http://kernel.ubuntu.com/~kernel-ppa/mainline/

Select latest version http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.17.4/

Download deb's:

```
wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.17.4/linux-headers-4.17.4-041704_4.17.4-041704.201807031235_all.deb
wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.17.4/linux-headers-4.17.4-041704-generic_4.17.4-041704.201807031235_amd64.deb
wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.17.4/linux-image-unsigned-4.17.4-041704-generic_4.17.4-041704.201807031235_amd64.deb
wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.17.4/linux-modules-4.17.4-041704-generic_4.17.4-041704.201807031235_amd64.deb

sudo dpkg -i *.deb

dkms status
```

