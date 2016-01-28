#!/bin/bash

echo "NM_CONTROLLED=no" >> /etc/sysconfig/network-scripts/ifcfg-lo  || exit 1  # NetworkManager for some reason stops lo from starting up. 
systemctl stop NetworkManager
systemctl disable NetworkManager   # could be causing the abrt-cli problem   
# for some reason i have to turn NetworkManager off, or connections keeps breaking after a minute. 
systemctl restart network



echo "RUNNING THE RPM COMMAND"
rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm
echo "  "
echo "  "
echo "  "
echo "  "
yum -y install http://yum.theforeman.org/releases/1.9/el7/x86_64/foreman-release.rpm
yum clean all

echo "  "
echo "  "
echo "  "
echo "  "
# yum info epel-release


echo "HERES A LIST OF ALL THE REPOS"
yum repolist
echo "  "
echo "  "
echo "  "
echo "  "
echo "INSTALLING THE FOREMAN-INSTALLER"
yum -y install foreman-installer
echo "  "
echo "  "
echo "  "
echo "  "

yum -y update
echo "  "
echo "  "
echo "  "
echo "  "


echo "output from hostname"
hostname
echo "  "
echo "  "
echo "  "
echo "  "


echo "output from hostname -f"
hostname -f
echo "  "
echo "  "
echo "  "
echo "  "

echo "output from facter hostname"
facter hostname
echo "  "
echo "  "
echo "  "
echo "  "

echo "output from facter fqdn"
facter fqdn
echo "  "
echo "  "
echo "  "
echo "  "


echo "Content of /etc/sysconfig/network"
cat /etc/sysconfig/network
echo "  "
echo "  "
echo "  "
echo "  "


echo "Content of /etc/hosts"
cat /etc/hosts
echo "  "
echo "  "
echo "  "
echo "  "







foreman-installer --foreman-admin-username=admin --foreman-admin-password=password  || exit 1





# note, run this to see what's available: yum list available | grep "^foreman"
# in this instance I have the following providers available:
#yum -y install foreman-ec2
#yum -y install foreman-vmware
#yum -y install foreman-assets
#yum -y install foreman-console
#yum -y install foreman-gce
#yum -y install foreman-libvirt
#yum -y install foreman-ovirt

# see this to find what foreman plugins are available and how to install them: http://theforeman.org/plugins/#2.Installation
# here are the plugins that will be installed:


# yum -y install ruby193-rubygem-foreman-mco
# yum -y install ruby193-rubygem-foreman-tasks
# yum -y install ruby193-rubygem-foreman_abrt
# yum -y install ruby193-rubygem-foreman_bootdisk
# yum -y install ruby193-rubygem-foreman_column_view
# yum -y install ruby193-rubygem-foreman_custom_parameters
# yum -y install ruby193-rubygem-foreman_default_hostgroup
# yum -y install ruby193-rubygem-foreman_dhcp_browser
# yum -y install ruby193-rubygem-foreman_digitalocean
# yum -y install ruby193-rubygem-foreman_discovery
# yum -y install ruby193-rubygem-foreman_docker
# yum -y install ruby193-rubygem-foreman_graphite
# yum -y install ruby193-rubygem-foreman_hooks
# yum -y install ruby193-rubygem-foreman_host_rundeck
# yum -y install ruby193-rubygem-foreman_memcache  # could be useful in future. 
# yum -y install ruby193-rubygem-foreman_one 
# yum -y install ruby193-rubygem-foreman_openscap  #could be useful
# yum -y install ruby193-rubygem-foreman_openstack_cluster
# yum -y install ruby193-rubygem-foreman_param_lookup
# yum -y install ruby193-rubygem-foreman_reserve
# yum -y install ruby193-rubygem-foreman_simplify
# yum -y install ruby193-rubygem-foreman_snapshot # could be useful in future. 
# yum -y install ruby193-rubygem-foreman_templates
# yum -y install ruby193-rubygem-foreman_xen
# yum -y install rubygem-foreman_api
# yum -y install rubygem-foreman_scap_client

# These should already be installed. 
# yum -y install rubygem-hammer_cli
# yum -y install rubygem-hammer_cli_foreman

# this is so to get the puppetmaster to autosign puppet agent certificicates. 
# This means that you no longer need to do "puppet cert sign...etc"
# http://www.puppetcookbook.com/posts/autosigning-client-certificates.html
# https://docs.puppetlabs.com/puppet/latest/reference/ssl_autosign.html#basic-autosigning-autosignconf
echo '*' >> /etc/puppet/autosign.conf



systemctl restart httpd
systemctl disable puppet


echo line159
abrt-cli list
[ `abrt-cli list | wc -l` -gt 0 ] && exit 1


# hammer host create --name puppetmaster.local --environment-id 1 --puppet-proxy-id 1 --interface Id=1,primary=true,provision=true --build false --enabled false --managed false

# puppet agent -t  # this caused the abrt-cli list problem, which could be to do with the NetworkManager not working. 
echo line164
abrt-cli list
[ `abrt-cli list | wc -l` -gt 0 ] && exit 1 
echo line167

puppet config set parser future --section all     # this only applies for puppet v3.0+. It is not required in puppet version 4+

echo "foreman installed, now about to do a reboot."
reboot 
sleep 120