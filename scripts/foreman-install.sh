#!/bin/sh

if ps -ef | grep "/usr/share/foreman" | grep -v grep 2> /dev/null
then
    echo "Foreman appears to all already be installed. Exiting..."
	exit 0
fi

rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm
yum -y install epel-release http://yum.theforeman.org/releases/1.8/el7/x86_64/foreman-release.rpm
yum -y install foreman-installer


echo "  "
echo "  "
echo "  "
echo "  "

echo "FACTER FQDN VALUE IS EQUAL TO:"
facter fqdn

echo "HOSTNAME FQDN VALUE IS EQUAL TO:"
hostname -f


if [ -z `facter domain` ]; then
  hostname "localhost.test"
  echo "localhost.test" > /etc/hostname
else
  hostname "localhost.`facter domain`"
  echo "localhost.`facter domain`" > /etc/hostname
fi 


echo "HOSTNAME FQDN VALUE IS NOW EQUAL TO:"
hostname -f


echo "CONTENT OF /ETC/HOSTS:"
cat /etc/hosts


echo "CONTENT OF /etc/sysconfig/network:"
cat /etc/sysconfig/network

echo "  "
echo "  "
echo "  "
echo "  "
echo "  "


# might need to permenantly change the hostname value using the "hostname" command. 
# Make sure above command gives the same output. If needed, change the hostname permanently via 'hostname' command 
# and editing appropriate configuration file(e.g. on Red Hat systems /etc/sysconfig/network). 
# If 'hostname -f' still returns unexpected result, check /etc/hosts and put hostname entry in the 
# correct order, for example
# 1.2.3.4 full.hostname.com full

# Fully qualified hostname must be the first entry on the line
#https://www.google.co.uk/search?q=Make+sure+above+command+gives+the+same+output.+If+needed%2C+change+the+hostname+permanently+via+%27hostname%27+command&oq=Make+sure+above+command+gives+the+same+output.+If+needed%2C+change+the+hostname+permanently+via+%27hostname%27+command&aqs=chrome..69i57.246j0j7&sourceid=chrome&es_sm=122&ie=UTF-8


foreman-installer \
--foreman-admin-username=vagrant \
--foreman-admin-password=vagrant

