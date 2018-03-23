# NVIDIA devices

## Install case for desktops

```
sudo apt-get install dkms linux-headers-generic
wget http://st.x.com/software/nvidia/drivers/NVIDIA-Linux-x86_64-384.111.run

./NVIDIA-Linux-x86_64-384.111.run --ui=none --no-questions --accept-license --no-x-check --dkms --no-opengl-files --no-nouveau-check --disable-nouveau
ldconfig -p | grep nvidia
modprobe nvidia
lsmod | grep nvidia


# CUDA and cudann!!!

./cuda_9.0.176_384.81_linux-run --silent --toolkit  --toolkitpath=/usr/local/cuda-9.0 --samples --samplespath=/usr/local/cuda-9.0/samples --override
./cuda_9.0.176.1_linux.run --accept-eula --silent --installdir=/usr/local/cuda-9.0/
./cuda_9.0.176.2_linux.run --accept-eula --silent --installdir=/usr/local/cuda-9.0/

wget http://st.cvisionlab.com/software/nvidia/cuda/cudann/9/7.1/cudnn-9.0-linux-x64-v7.1.tgz
tar xvzf cudnn-9.0-linux-x64-v7.1.tgz

cp cuda/include/cudnn.h /usr/local/cuda/include
cp cuda/lib64/libcudnn* /usr/local/cuda/lib64
chmod a+r /usr/local/cuda/include/cudnn.h /usr/local/cuda/lib64/libcudnn*

ldconfig

```

## Install case for laptops

```
sudo apt-get install dkms linux-headers-generic
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt-get update

sudo apt-get install nvidia-384

ldconfig -p | grep nvidia
modprobe nvidia
lsmod | grep nvidia
```

## Using DKMS

```bash
 
# dkms autoinstall

# See what you can compile (here:)?
/home/sysadmin# ll /usr/src/
total 48
drwxr-xr-x 12 root root 4096 Jan  9 21:32 ./
drwxr-xr-x 12 root root 4096 Aug 22 12:36 ../
drwxr-xr-x  3 root root 4096 Dec 26 18:17 anbox-modules-ashmem-9~zesty1/
drwxr-xr-x  2 root root 4096 Dec 26 18:17 anbox-modules-binder-9~zesty1/
drwxr-xr-x  2 root root 4096 Aug 22 12:36 bbswitch-0.8/
drwxr-xr-x  4 root root 4096 Oct  3 14:28 cudnn_samples_v7/
drwxr-xr-x 27 root root 4096 Nov 23 07:40 linux-headers-4.10.0-40/
drwxr-xr-x  7 root root 4096 Nov 23 07:40 linux-headers-4.10.0-40-generic/
drwxr-xr-x 27 root root 4096 Dec 26 16:18 linux-headers-4.10.0-43/
drwxr-xr-x  7 root root 4096 Dec 26 16:18 linux-headers-4.10.0-43-generic/
drwxr-xr-x  8 root root 4096 Jan  9 21:32 nvidia-384-384.111/
drwxr-xr-x 12 root root 4096 Sep  7 11:56 virtualbox-5.1.22/

# Manually
dkms install nvidia/384-384.111 -k 4.10.0-40-generic

# See what is comiled here:
ll /lib/modules/4.10.0-40-generic/updates/dkms/

modprobe nvidia_384 nvidia_384_uvm nvidia_384_drm nvidia_384_modeset
```

Driver calls 
```
/usr/sbin/dkms build -m nvidia -v 384.98 -k 4.13.0-26-generic
```

**Get kernel temp**

```bash
nvidia-smi -q -d TEMPERATURE
```

#### error `/dev/dri/card0 not authenticated`

add `drm.rnodes=1` to `GRUB_CMDLINE_LINUX_DEFAULT` in `/etc/default/grub`

and run:

```bash
update-grub2
reboot
```

see: 

http://lists.freedesktop.org/archives/beignet/2014-November/004475.html
http://stackoverflow.com/questions/31901160/installed-beignet-to-use-opencl-on-intel-but-opencl-programs-only-work-when-run
