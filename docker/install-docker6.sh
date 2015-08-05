#!/bin/sh
# # This script installs docker on Oracle/Centos/RHEL 6.x
# https://docs.docker.com/installation/centos/#manual-installation-of-latest-docker-release

# install the epel repo which contains the docker rpm
yum -y install epel-release


# this is a different app that happens to share the same name of "docker"
# so removing this to avoid conflicts
yum remove -y docker  


# install docker 
# the docker rpm should be available in the OS's main repos. 
yum -y install docker-io

service docker start

chkconfig docker on


# Here are some sanity checks to ensure docker is isntalled and running.
docker -v
docker version
docker info

# The main interaction the docker client has with the docker client is via the docker.sock file:
ls -l /run | grep docker.sock
# this outputs: 
# srw-rw----.  1 root           docker            0 Aug  4 10:17 docker.sock

# Notice the "docker" group. This means that any members of the docker group will have 
# full docker priveleges. Hence we add the vagrant user to the group:

