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


