#!/bin/bash

if [ ! -f /vagrant/personal-data/r10k.yaml ]; then
  exit 0
fi

cp -f /vagrant/personal-data/r10k.yaml /etc/puppetlabs/r10k/r10k.yaml
r10k deploy environment

for environment in `ls /etc/puppet/environments`; do
    hammer environment create --name $environment
	hammer proxy import-classes --environment $environment --id 1
done

exit 0




