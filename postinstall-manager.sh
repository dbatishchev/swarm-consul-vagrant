#! /bin/bash

sed -i "s/10.0.2.3/8.8.8.8/g" /etc/resolv.conf
apt-get update --yes && apt-get upgrade --yes

# Install docker
curl -sSL https://get.docker.com/ | sudo sh
service docker stop
sed -i "s/DOCKER_OPTS=/DOCKER_OPTS='-H tcp:\/\/0.0.0.0:2375 -H unix:///var/run/docker.sock'/g" /etc/init/docker.conf
service docker start

# Install docker-compose
curl -sSL https://github.com/docker/compose/releases/download/1.5.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose | sudo sh
chmod +x /usr/local/bin/docker-compose | sudo sh

export DOCKER_HOST=tcp://0.0.0.0:2375
echo "export DOCKER_HOST=tcp://0.0.0.0:2375" >> /root/.bashrc

usermod -aG docker vagrant | sudo sh

docker pull swarm | sudo sh
cluster_id=`docker run --rm swarm create`
nodes="$@"
for node in $nodes
do
  echo "Adding node $node to cluster $cluster_id"
  docker run -d swarm join --addr="$node:2375" consul://192.168.50.15:8500/swarm token://$cluster_id
done

docker run -d -p 5000:5000 swarm manage consul://192.168.50.15:8500/swarm token://$cluster_id
docker run --rm swarm list token://$cluster_id