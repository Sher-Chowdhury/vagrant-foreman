#!/bin/sh

gem install r10k --no-ri --no-rdoc
mkdir -p /etc/puppetlabs/r10k
echo "PATH=$PATH:/usr/local/bin" >> /root/.bashrc   # this is where r10k is executable is stored. 


gem install bundler --no-ri --no-rdoc
gem install rake --no-ri --no-rdoc

#gem install puppet-lint --no-ri --no-rdoc    # required by puppet vim plugin: https://github.com/rodjek/vim-puppet 
#gem install puppet-syntax --no-ri --no-rdoc  # required by puppet vim plugin: https://github.com/rodjek/vim-puppet


