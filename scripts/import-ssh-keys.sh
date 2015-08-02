#!/bin/sh

runuser -l vagrant -c "cp -f /vagrant/personal-data/id_rsa* ~/.ssh"
chmod 700 /home/vagrant/.ssh/id_rsa
chmod 644 /home/vagrant/.ssh/id_rsa.pub


# this disables RSA fingerprint checking when connecting to a new host. 
echo "
Host *
    StrictHostKeyChecking no
" > /home/vagrant/.ssh/config