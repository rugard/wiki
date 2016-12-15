# Fisheye's
# latest

vlc rtsp://guest:guest@fisheye:8554/CH001.sdp?tcp

rtsp://admin:4321@fisheye3:554/profile1/media.smp


### not working in 14.04

```bash
avconv -i rtsp://guest:guest@192.168.128.23:8554/CH001.sdp?tcp /tmp/ffmpeg-mimas-10-mbit.av
```

#### worked in 12.04

```bash
ffmpeg -i rtsp://guest:guest@192.168.128.23:8554/CH001.sdp?tcp /tmp/ffmpeg.avi
```
