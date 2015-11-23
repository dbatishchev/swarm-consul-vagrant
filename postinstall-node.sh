#! /bin/bash

sed -i "s/10.0.2.3/8.8.8.8/g" /etc/resolv.conf
apt-get update --yes && apt-get upgrade --yes | sudo sh


# Install docker
curl -sSL https://get.docker.com/ | sudo sh
service docker stop
#sed -i "s/DOCKER_OPTS=/DOCKER_OPTS='-H tcp:\/\/0.0.0.0:2375'/g -H unix:///var/run/docker.sock" /etc/init/docker.conf
echo 'DOCKER_OPTS="-H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock"' >> /etc/default/docker
service docker start

usermod -aG docker vagrant | sudo sh

# Install docker-compose
curl -sSL https://github.com/docker/compose/releases/download/1.5.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose | sudo sh
chmod +x /usr/local/bin/docker-compose | sudo sh