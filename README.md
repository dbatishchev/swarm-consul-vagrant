vagrant ssh manager
vagrant ssh node01

docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)

docker -H tcp://0.0.0.0:8333 info

docker exec -it [container-id] bash

docker -H tcp://192.168.50.15:8333 run -dt --name swarm-test busybox /bin/sh

docker -H tcp://192.168.50.15:8333 ps