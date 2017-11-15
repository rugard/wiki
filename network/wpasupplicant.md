
# Wpasupplicant

See `zless /usr/share/doc/wpasupplicant/README.Debian.gz`

```
auto enp5s0
iface enp5s0 inet static
  address 192.168.126.1
  netmask 255.255.255.0
  post-up route add -net 192.168.128.0/24 gw 192.168.129.1

auto wlp6s0
iface wlp6s0 inet dhcp
    wpa-ssid Name
    wpa-psk Password
    # options below need for hidden wlan networks
    wpa-ap-scan 1
    wpa-scan-ssid 1
```
