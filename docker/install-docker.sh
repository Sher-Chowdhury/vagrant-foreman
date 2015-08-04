#!/bin/sh
# https://docs.docker.com/installation/centos/#manual-installation-of-latest-docker-release

# install docker 
# the docker rpm should be available in the core OS repos. 
yum -y install docker

systemctl start docker

systemctl enable docker

# give vagrant user full priveleges to use docker

groupadd docker
gpasswd -a vagrant docker 