#!/bin/sh

gem install r10k --no-ri --no-rdoc
mkdir -p /etc/puppetlabs/r10k
cp /vagrant/files/r10k.yaml /etc/puppetlabs/r10k/


gem install bundler --no-ri --no-rdoc
gem install rake --no-ri --no-rdoc


