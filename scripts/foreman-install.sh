#!/bin/sh


rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm
yum -y install epel-release http://yum.theforeman.org/releases/1.8/el7/x86_64/foreman-release.rpm
yum -y install foreman-installer

yum -y update

# foreman-installer

foreman-installer --foreman-admin-username=admin --foreman-admin-password=password



systemctl stop NetworkManager   
# for some reason i have to turn this off, or connections keeps breaking after a minute. 
systemctl restart network
systemctl restart httpd
