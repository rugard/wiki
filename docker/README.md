# Docker

Run bash in running container:
```bash
docker exec -it kickass_leakey /bin/bash
```

```bash
docker load --input one_move_one_mysql.tar
docker run -d --publish 7654:7654 -ti cvisionlab/moveavserver /usr/bin/avserver
```
