#!/bin/bash
# this script is run on the agent only. 

rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm

yum -y install puppet facter

echo "    certname          = `hostname --fqdn`" >> /etc/puppet/puppet.conf
echo "    server            = puppetmaster.local" >> /etc/puppet/puppet.conf


ping -c 3 puppetmaster.local
if [ $? -eq 0 ]; then
  puppet agent -t  2>/dev/null
  puppet agent -t
fi
