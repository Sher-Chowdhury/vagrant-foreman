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


groupadd docker  
cat /etc/group | grep docker   # This is to confirm that the docker group exists, but with no members at this stage. 
                               # http://linuxg.net/how-to-administer-groups-with-the-unix-linux-gpasswd-command/

              
gpasswd -a vagrant docker      # If you are running this manually then you need to restart the terminal session to clear the old cache. 

docker run centos ls       # this will take awhile, about 5mins. Because it is downloading the image from docker.io website for the first time. 
docker run centos ls       # This should 
# If you want to run the above command manually then also specify the "-it" options. for (i)nteractive and (t)erminal, e.g. :   docker -it run centos ls

netstat -tlp | grep docker   # By default, the docker service listens to a socket port. 
                             # So nothing will get outputted here. 
							 # But we want it to also listen on a network port too....acutally no because that would be a security problem.  

# Needed to do a network reset here. Not sure whey though. 
systemctl restart NetworkManager
systemctl restart network							 
							 
							 
# first we need to stop docker: 
# systemctl stop docker       

# Then work out what IP address docker should be listening on.  
#ipaddress=`ip addr show | grep 192 | awk '{print $2}' | cut -d'/' -f1`



# Now start the docker server. 
# Port 2375 is the standard port that docker listens on. 
# We also specify "-d" to indicate that it needs to be started up as a deamon. 
# We also "$" so that it starts as a background process and we get the shell back and it doesn't hang. 
# Notice that we specified to "-H" to make our single docker service listen on two sources, the web socket, and the network port. 


#netstat -tlp | grep docker   # this should now show docker is listening on a network port 	

# Next we want our docker client interacting via the network address rather than the socket address, 
# This is done by setting the following environment level variable. 

#export DOCKER_HOST="tcp://${ipaddress}:2375"   



#echo "The 'DOCKER_HOST' is set to $DOCKER_HOST"
			 
# If you want to unset this command again, then do: "export DOCKER_HOST="

# To make this permenant we do:
#echo "export DOCKER_HOST=tcp://${ipaddress}" >> /etc/bashrc
#source /etc/bashrc

# Now we start the docker daemon:

#sleep 10
#echo "starting nohup"
#nohup docker -H "${ipaddress}:2375" -d &
#echo "ending nohup"
			 
			 
### Background info ###
# to spin up a new container at start an interactive shell inside it, you do:
#
# [vagrant@puppetmaster ~]$ docker run -it centos /bin/bash
#
# Here we are starting an (i)nteractive shell with (t)ty. 
# By running this we end up with a prompt that looks like this:
#
# [root@4bd283ab9f50 /]#
# 
# That's because:
#
# [root@7bfb0e63b166 /]# hostname -f
# 7bfb0e63b166
# 
# Here you can do:
#
# $ ping 8.8.8.8       # note this will work if you network allows pinging. 
#                      # In a lot of workplaces, pinging is disabled for security purposes. 
#
#
# $ ps -elf
# F S UID        PID  PPID  C PRI  NI ADDR SZ WCHAN  STIME TTY          TIME CMD
# 4 S root         1     0  0  80   0 -  2936 wait   08:34 ?        00:00:00 /bin/bash
# 0 R root        20     1  0  80   0 -  4941 -      08:35 ?        00:00:00 ps -elf
#
#
# [root@7bfb0e63b166 /]# cat /etc/hosts
# 172.17.0.14	7bfb0e63b166                      # notice this alias for the hostname
# 127.0.0.1	localhost
# ::1	localhost ip6-localhost ip6-loopback
# fe00::0	ip6-localnet
# ff00::0	ip6-mcastprefix
# ff02::1	ip6-allnodes
# ff02::2	ip6-allrouters
# [root@7bfb0e63b166 /]# 
# 
# This IP addrss is also our main interface's ip address:
#
# 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN 
#     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
#     inet 127.0.0.1/8 scope host lo
#        valid_lft forever preferred_lft forever
#     inet6 ::1/128 scope host 
#        valid_lft forever preferred_lft forever
# 35: eth0: <BROADCAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP 
#     link/ether 02:42:ac:11:00:0e brd ff:ff:ff:ff:ff:ff
#     inet 172.17.0.14/16 scope global eth0                                  Notice this ip address matches,. 
#        valid_lft forever preferred_lft forever
#     inet6 fe80::42:acff:fe11:e/64 scope link 
#        valid_lft forever preferred_lft forever
# [root@7bfb0e63b166 /]# 
#
#
# Let's confirm that we have a RHEL related distro:
#
# [root@a894765524cc /]# cat /etc/redhat-release
# CentOS Linux release 7.1.1503 (Core)
#
#
#
#
#
#

# this lists docker containers that are currently running:
docker ps

# This lists all containers that have been run on this machine. 
docker ps -a

# The above will list the docker's id. You can use this ID to log back into the docker container,
# To do this you need to run the following 2 commands:

# $ docker start {container-id}    # switches ON the container
# $ docker attach {container-id}   # logs into the container again. 

# When you exit again, the container will power-off again. 

# Note any files you create in a container are persistant.  




