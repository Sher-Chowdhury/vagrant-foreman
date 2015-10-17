#!/bin/bash

gem source https://rubygems.org

gem install r10k --no-ri --no-rdoc
mkdir -p /etc/puppetlabs/r10k
echo "PATH=$PATH:/usr/local/bin" >> /root/.bashrc   # this is where r10k is executable is stored. 


gem install bundler --no-ri --no-rdoc
gem install rake --no-ri --no-rdoc


# Installing rvm for the vagrant user
runuser -l vagrant -c 'gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3'
runuser -l vagrant -c 'curl -sSL https://get.rvm.io | bash -s stable --ruby'
