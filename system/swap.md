# Disable swap oin sirius 

```
cat /proc/swaps

swapoff /dev/sda3

sgdisk /dev/sda

# change type to plan9 - `3900`

dd if=/dev/zero of=/dev/sda3 bs=1M count=100
```
