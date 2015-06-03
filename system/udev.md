# Add devices to 70-net...

udevadm trigger --action=add


# Change usb disk device name

```bash
udevadm info -a -p $(udevadm info -q path -n /dev/sdd)
```

```
#99-local.rules
KERNEL=="sd?", ATTRS{manufacturer}=="Seagate", ATTRS{product}=="FA GoFlex Desk", ATTRS{serial}=="NA0KLW9F", SYMLINK+="sdm"
```
