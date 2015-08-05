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

docker run centos ls       # this will take awhile, about 5mins. Because it is downloading the image from docker.io website for the first time. 
docker run centos ls       # This should 
# If you want to run the above command manually then also specify the "-it" options. for (i)nteractive and (t)erminal, e.g. :   docker -it run centos ls

netstat -tlp | grep docker   # By default, the docker service listens to a socket port. 
                             # So nothing will get outputted here. 
							 # But we want it to also listen on a network port too. 

# Needed to do a network reset here. Not sure whey though. 
systemctl restart NetworkManager
systemctl restart network							 
							 
							 
# first we need to stop docker: 
systemctl stop docker       

# Then work out what IP address docker should be listening on.  
ipaddress=`ip addr show | grep 192 | awk '{print $2}' | cut -d'/' -f1`



# Now start the docker server. 
# Port 2375 is the standard port that docker listens on. 
# We also specify "-d" to indicate that it needs to be started up as a deamon. 
# We also "$" so that it starts as a background process and we get the shell back and it doesn't hang. 
# Notice that we specified to "-H" to make our single docker service listen on two sources, the web socket, and the network port. 
docker -H ${ipaddress}:2375 -H unix:///var/run/docker.sock -d &		




netstat -tlp | grep docker   # this should now show docker is listening on a network port 	

# Next we want our docker client interacting via the network address rather than the socket address, 
# This is done by setting the following environment level variable. 

export DOCKER_HOST="tcp://${ipaddress}"   # might need to add this to the bashrc file, or a user level file, e.g. .profile.  
			 
# If you want to unset this command again, then do: "export DOCKER_HOST="


			 
			 
			 
			 
