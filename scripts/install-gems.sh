#!/bin/sh

gem install r10k --no-ri --no-rdoc
mkdir /etc/puppetlabs/
cp /vagrant/files/r10k.yaml /etc/puppet/

gem install bundler --no-ri --no-rdoc
gem install rake --no-ri --no-rdoc


