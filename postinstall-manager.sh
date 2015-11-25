#! /bin/bash

sed -i "s/10.0.2.3/8.8.8.8/g" /etc/resolv.conf
apt-get update --yes && apt-get upgrade --yes

# Install docker
curl -sSL https://get.docker.com/ | sudo sh
service docker stop
#echo 'DOCKER_OPTS="-H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock"' >> /etc/default/docker
echo 'DOCKER_OPTS="-H tcp://0.0.0.0:2375"' >> /etc/default/docker
service docker start

export DOCKER_HOST=tcp://192.168.50.15:8333
#echo "export DOCKER_HOST=tcp://192.168.50.15:8333" >> ~/.bash_profile
#export DOCKER_HOST=tcp://192.168.50.15:8333
echo "export DOCKER_HOST=tcp://192.168.50.15:8333" >> /root/.bashrc
echo "export DOCKER_HOST=tcp://192.168.50.15:8333" >> ~/.bashrc
echo "export DOCKER_HOST=tcp://192.168.50.15:8333" >> ~/.bash_profile

# Install docker-compose
curl -sSL https://github.com/docker/compose/releases/download/1.5.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose | sudo sh
chmod +x /usr/local/bin/docker-compose | sudo sh


usermod -aG docker vagrant | sudo sh