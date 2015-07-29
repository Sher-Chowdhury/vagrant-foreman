#!/bin/sh

rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm

yum -y install puppet facter

echo "    certname          = `hostname --fqdn`" >> /etc/puppet/puppet.conf
echo "    server            = puppetmaster.local" >> /etc/puppet/puppet.conf

puppet agent -t  2>/dev/null
puppet agent -t