#!/bin/bash
echo "### about to run r10k-run.sh script"
puppet agent -t   # the foreman server needs to appear as a host beforem it can import-classes. 

if [ -f /vagrant/personal-data/r10k.yaml ]; then

  cp -f /vagrant/personal-data/r10k.yaml /etc/puppetlabs/r10k/r10k.yaml
  r10k deploy environment -v 
  
  chown vagrant:vagrant -R /etc/puppet/environments
  
  
  for environment in `ls /etc/puppet/environments`; do
      hammer environment create --name $environment
  	hammer proxy import-classes --environment $environment --id 1
  done
fi





exit 0




