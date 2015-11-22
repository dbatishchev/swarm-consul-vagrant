#! /bin/bash

sed -i "s/10.0.2.3/8.8.8.8/g" /etc/resolv.conf
apt-get update --yes && apt-get upgrade --yes

# Install docker
curl -sSL https://get.docker.com/ | sudo sh
service docker stop
sed -i "s/DOCKER_OPTS=/DOCKER_OPTS='-H tcp:\/\/0.0.0.0:2375'/g -H unix:///var/run/docker.sock" /etc/init/docker.conf
service docker start