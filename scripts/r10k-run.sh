#!/bin/bash

if [ -f /vagrant/personal-data/r10k.yaml ]; then

  cp -f /vagrant/personal-data/r10k.yaml /etc/puppetlabs/r10k/r10k.yaml
  r10k deploy environment
  
  chown vagrant:vagrant -R /etc/puppet/environments
  
  
  for environment in `ls /etc/puppet/environments`; do
      hammer environment create --name $environment
  	hammer proxy import-classes --environment $environment --id 1
  done
fi



# puppet agent -t || exit 1  # this is not really to do with r10k run. but added it here anyway. 


exit 0




