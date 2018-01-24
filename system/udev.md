# Add devices to 70-net...

udevadm trigger --action=add


# Change usb disk device name

```bash
udevadm info -a -p $(udevadm info -q path -n /dev/sdd)
```

```
#99-local.rules
# old disk
#KERNEL=="sd?", ATTRS{manufacturer}=="Seagate", ATTRS{product}=="FA GoFlex Desk", ATTRS{serial}=="NA0KLW9F", SYMLINK+="sdm"
#new disk
KERNEL=="sd?", ATTRS{manufacturer}=="Seagate", ATTRS{product}=="Expansion Desk", ATTRS{serial}=="NA8F2VCV", SYMLINK+="sdm"
```

# Some tip

Found a device placed under Usb 3.1, Thunderbolt.

```
lshw | grep -C 5 r8152
```

```
root@machine:/sys/bus/usb/drivers/r8152# udevadm info -a -p $(udevadm info -q path -n /dev/bus/usb/004/003)

Udevadm info starts with the device specified by the devpath and then
walks up the chain of parent devices. It prints for every device
found, all possible attributes in the udev rules key format.
A rule to match, can be composed by the attributes of the device
and the attributes from one single parent device.

  looking at device '/devices/pci0000:00/0000:00:1d.6/0000:06:00.0/0000:07:02.0/0000:3e:00.0/usb4/4-1/4-1.2':
    KERNEL=="4-1.2"
    SUBSYSTEM=="usb"
    DRIVER=="usb"
    ATTR{authorized}=="1"
    ATTR{avoid_reset_quirk}=="0"
    ATTR{bConfigurationValue}=="1"
    ATTR{bDeviceClass}=="00"
    ATTR{bDeviceProtocol}=="00"
    ATTR{bDeviceSubClass}=="00"
    ATTR{bMaxPacketSize0}=="9"
    ATTR{bMaxPower}=="256mA"
    ATTR{bNumConfigurations}=="2"
    ATTR{bNumInterfaces}==" 1"
    ATTR{bcdDevice}=="3001"
    ATTR{bmAttributes}=="a0"
    ATTR{busnum}=="4"
    ATTR{configuration}==""
    ATTR{devnum}=="3"
    ATTR{devpath}=="1.2"
    ATTR{idProduct}=="8153"
    ATTR{idVendor}=="0bda"
    ATTR{ltm_capable}=="yes"
    ATTR{manufacturer}=="Realtek"
    ATTR{maxchild}=="0"
    ATTR{product}=="USB 10/100/1000 LAN"
    ATTR{quirks}=="0x0"
    ATTR{removable}=="removable"
    ATTR{serial}=="000001000000"
    ATTR{speed}=="5000"
    ATTR{urbnum}=="1009103"
    ATTR{version}==" 3.00"
```

```
vim /etc/udev/rules.d/70-wifi-wired-exclusive.rules:
ACTION=="remove", SUBSYSTEM=="usb", ATTRS{idProduct}=="8153", ATTRS{idVendor}=="0bda", RUN+="/etc/NetworkManager/dispatcher.d/70-wifi-wired-exclusive.sh"
```

Test it:
```
udevadm control --reload-rules
udevadm trigger -v -c remove -s usb -a "idVendor=0bda"
```
