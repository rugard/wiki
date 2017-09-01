# Docker

**Run bash in running container:**
```bash
docker exec -it kickass_leakey /bin/bash
```

**Useful example commands:**

```bash
docker load --input one_move_one_mysql.tar
docker run -d --publish 7654:7654 -ti cvisionlab/moveavserver /usr/bin/avserver
```

```bash
docker save cvisionlab/vcakinder:150128 | gzip > vcakinder_150128.tgz
docker save cvisionlab/vcakinder:150128 > /data/vcakinder_150128.tar
```

**Load in images at once, without saving image file to disk**

> `SimpleHTTPServer` cannot serve to multiple clients. Файл будет отдан последовательно каждому, но одновременно будет грузиться только одним.


```bash
python -m SimpleHTTPServer
wget -O - -o /tmp/wget http://192.168.129.104:8000/tetn_alrotation-v1_with_data.tgz | docker load
```
