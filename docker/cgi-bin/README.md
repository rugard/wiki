TODO не рабочее, надо доделать


docker build -t gera/ipsec-trafficstatus:v.0.1 .

docker run --privileged --pid=host -ti -d gera/ipsec-trafficstatus:v.0.1

docker run --privileged --pid=host -it python:2.7 nsenter -t 1 -m -u -n -i sh
