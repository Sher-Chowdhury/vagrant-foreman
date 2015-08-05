#!/bin/sh
# dot source this script to run it. 


#echo "INFO: uninstalling puppet (this is only done inside virtualbox and foreman provisioned boxes)"
#echo "this is done becuase puppet agents have the wrong version of the puppet agent installed."
yum -y remove puppet
rm -rf /etc/puppet/*
rm -rf /var/lib/puppet/*


#echo "INFO: using system ruby (this is only done inside virtualbox and foreman provisioned boxes)"
rvm use system


echo "INFO: Installing foreman repos"
yum -y install http://yum.theforeman.org/releases/1.8/el6/x86_64/foreman-release.rpm

echo "INFO: Installing puppetlab repos"
rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm

#echo "INFO: Installing epel repos (this is only done inside virtualbox)"
#wget http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
#rpm -ivh epel-release-6-8.noarch.rpm

echo "INFO: Installing the foreman-installer rpm"
yum -y install foreman-installer


echo "install apr. This is required on a kickstart provisioned machine only"
yum -y install apr

echo "INFO: running the foreman-installer. Note you have to always run this in order for the next command to work."
foreman-installer \
  --foreman-admin-username=admin \
  --foreman-admin-password=password \

echo "INFO: running the foreman-installer again with custom configurations"
foreman-installer \
  --foreman-admin-username=admin \
  --foreman-admin-password=password \
  --no-enable-foreman-compute-ec2 \
  --no-enable-foreman-compute-gce \
  --no-enable-foreman-compute-libvirt \
  --no-enable-foreman-compute-openstack \
  --no-enable-foreman-compute-rackspace \
  --enable-foreman-compute-vmware \
  --enable-foreman-plugin-bootdisk \
  --enable-foreman-plugin-default-hostgroup \
  --no-enable-foreman-plugin-discovery \
  --enable-foreman-plugin-docker \
  --enable-foreman-plugin-hooks \
  --enable-foreman-plugin-setup \
  --enable-foreman-plugin-templates \
  --foreman-proxy-realm-provider=false \
  --foreman-proxy-tftp-listen-on=both \
  --foreman-proxy-dhcp-managed=false  \
  --foreman-proxy-tftp-syslinux-root=/usr/share/syslinux \
  --foreman-proxy-puppetrun=true \
  --foreman-proxy-puppetrun-provider=puppetssh \
  --foreman-proxy-puppetca=false \
  --foreman-proxy-puppetssh-user=root \
  --foreman-proxy-puppetssh-keyfile=/usr/share/foreman-proxy/.ssh/id_rsa \
  --puppet-server=false 

