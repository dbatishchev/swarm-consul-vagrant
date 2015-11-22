#! /bin/bash

sed -i "s/10.0.2.3/8.8.8.8/g" /etc/resolv.conf
apt-get update --yes && apt-get upgrade --yes
apt-get install python-pip python-dev build-essential --yes | sudo sh

# Install docker
curl -sSL https://get.docker.com/ | sudo sh
service docker stop
sed -i "s/DOCKER_OPTS=/DOCKER_OPTS='-H tcp:\/\/0.0.0.0:2375 -H unix:///var/run/docker.sock'/g" /etc/init/docker.conf
service docker start

pip install docker-compose

export DOCKER_HOST=tcp://0.0.0.0:2375
echo "export DOCKER_HOST=tcp://0.0.0.0:2375" >> /root/.bashrc

docker pull swarm
cluster_id=`docker run --rm swarm create`
nodes="$@"
for node in $nodes
do
  echo "Adding node $node to cluster $cluster_id"
  docker run -d swarm join --addr="$node:2375" consul://192.168.50.15:8500/swarm token://$cluster_id
done

docker run -d -p 5000:5000 swarm manage consul://192.168.50.15:8500/swarm token://$cluster_id
docker run --rm swarm list token://$cluster_id