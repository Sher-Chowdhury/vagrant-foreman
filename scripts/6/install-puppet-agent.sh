#!/bin/bash
# this script is run on the agent only. 

echo "INFO: About to run ./script/6/install-puppet-agent.sh"

rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm

yum -y install puppet facter

echo "    certname          = `hostname --fqdn`" >> /etc/puppet/puppet.conf
echo "    server            = puppetmaster.local" >> /etc/puppet/puppet.conf


ping -c 3 puppetmaster.local
if [ $? -eq 0 ]; then
  puppet agent -t  2>/dev/null
  puppet agent -t
fi
