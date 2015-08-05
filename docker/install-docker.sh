#!/bin/sh
# This script installs docker on Oracle/Centos/RHEL 7
# https://docs.docker.com/installation/centos/#manual-installation-of-latest-docker-release

# install docker 
# the docker rpm should be available in the OS's main repos. 
yum -y install docker

systemctl start docker

systemctl enable docker


# Here are some sanity checks to ensure docker is installed and running.
docker -v         # basic version info
docker version    # showd more detailed info
docker info       # shows number of containers and images. Also shows storage drivers, execution driver,
                  # kernel version, Operating System name and version,...etc.   




# give vagrant user full priveleges to use docker

cat /etc/group | grep docker   # This is to confirm that the docker group exists, but with no members at this stage. 
                               # http://linuxg.net/how-to-administer-groups-with-the-unix-linux-gpasswd-command/

groupadd docker                
gpasswd -a vagrant docker      # If you are running this manually then you need to restart the terminal session to clear the old cache. 