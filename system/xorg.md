# XServer, xorg, X11 and etc


**Purge current xorg (log files also) and reinstall it**
```bash
sudo apt-get purge --auto-remove xorg.*
sudo apt-get install ubuntu-desktop
```
>tested on ubuntu 12.04 titan

**Purge nvidia drivers**

```bash
sudo apt-get purge --auto-remove nvidia.*
sudo apt-get update
sudo apt-get install nvidia-current-updates nvidia-settings-updates
```


```
sudo docker run --rm -it -v /run/user/2087/gdm/Xauthority:/root/.Xauthority -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY  some_image_with_firefox

# firefox
```
