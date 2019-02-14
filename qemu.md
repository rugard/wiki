

```
kvm -cdrom ~/Downloads/ReactOS-0.4.2-live.iso -vga std -localtime -net nic,model=ne2k_pci -net user -m 128
```

```
qemu-system-x86_64 -m 1024 -boot n -option-rom /usr/share/qemu/pxe-rtl8139.rom -net nic
```

USB:

> https://github.com/qemu/qemu/blob/master/docs/usb2.txt

```bash
$ qemu-system-x86_64 -m 2048 -cdrom /home/user/Downloads/alkid/alkid.live.cd.standard/alkid.live.cd.iso -boot menu=on -usb -device usb-ehci,id=ehci -device usb-host,bus=ehci.0,hostbus=2,hostaddr=4

$ qemu-system-x86_64 -enable-kvm -m 2048 -cdrom /home/user/Downloads/winpe/WinPE10_8_Sergei_Strelec_x86_x64_2019.01.28_Russian.iso -boot menu=on -usb -device usb-ehci,id=ehci -device usb-host,bus=ehci.0,hostbus=2,hostaddr=4
```
