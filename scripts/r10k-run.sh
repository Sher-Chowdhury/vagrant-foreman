#!/bin/bash

if [ -f /vagrant/personal-data/r10k.yaml ]; then
  cp -f /vagrant/personal-data/r10k.yaml /etc/puppetlabs/r10k/r10k.yaml
  r10k deploy environment
fi