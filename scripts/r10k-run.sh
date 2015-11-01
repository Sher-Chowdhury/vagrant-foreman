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



echo "NM_CONTROLLED=no" >> /etc/sysconfig/network-scripts/ifcfg-lo  || exit 1  # NetworkManager for some reason stops this from starting up. 
# systemctl stop NetworkManager
# systemctl disable NetworkManager
systemctl restart network


# puppet agent -t || exit 1  # this is not really to do with r10k run. but added it here anyway. 


exit 0




