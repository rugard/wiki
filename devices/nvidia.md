# NVIDIA devices

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
