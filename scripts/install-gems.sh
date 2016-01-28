#!/bin/bash

echo "Started install-gems.sh"
echo "line4"
abrt-cli list
#[ `abrt-cli list | wc -l` -gt 0 ] && exit 1 

gem source https://rubygems.org

gem install r10k --no-ri --no-rdoc
mkdir -p /etc/puppetlabs/r10k
echo "PATH=$PATH:/usr/local/bin" >> /root/.bashrc   # this is where r10k is executable is stored. 


#gem install bundler --no-ri --no-rdoc
#gem install rake --no-ri --no-rdoc


# Installing rvm for the vagrant user
runuser -l vagrant -c 'gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3'
runuser -l vagrant -c 'curl -sSL https://get.rvm.io | bash -s stable --ruby'
#runuser -l vagrant -c 'echo "json"  >> ~/.rvm/gemsets/global.gems'            # required by vim plugins
#runuser -l vagrant -c 'echo "puppet-syntax"  >> ~/.rvm/gemsets/global.gems'   # required by vim plugins
#runuser -l vagrant -c 'echo "puppet-lint"  >> ~/.rvm/gemsets/global.gems'   # required by vim plugins
runuser -l vagrant -c 'rvm install 2.0.0'  
runuser -l vagrant -c 'rvm install 1.9.3'
runuser -l vagrant -c 'rvm install 1.8.7'
runuser -l vagrant -c 'rvm install 2.2.3'
runuser -l vagrant -c 'rvm use --default 2.0.0'
runuser -l vagrant -c 'rvm all do gem install bundler'  
runuser -l vagrant -c 'rvm all do gem install json'
runuser -l vagrant -c 'rvm all do gem install puppet-syntax'
runuser -l vagrant -c 'rvm all do gem install puppet-lint'



#runuser -l vagrant -c 'rvm use system'

echo "line35"
abrt-cli list


#[ `abrt-cli list | wc -l` -gt 0 ] && exit 1 

systemctl enable NetworkManager 

echo "rvm now setup, now about to do a reboot."
reboot
sleep 120

