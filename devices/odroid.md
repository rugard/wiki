# Odroid

**Odroid cpu burn test**

```bash
apt-get install cpuburn

burnCortexA9 || echo $? &
burnCortexA9 || echo $? &
burnCortexA9 || echo $? &
burnCortexA9 || echo $? &
burnCortexA9 || echo $? &
burnCortexA9 || echo $? &
burnCortexA9 || echo $? &
burnCortexA9 || echo $? &
killall burnCortexA9

cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq
cat /sys/devices/system/cpu/cpu?/cpufreq/cpuinfo_cur_freq

watch -n 1 cat /sys/devices/virtual/thermal/thermal_zone0/temp
```

