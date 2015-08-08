#!/bin/bash
# http://offandon.org/2015/07/foreman-1-8-and-puppet-run/
# https://groups.google.com/forum/#!topic/foreman-users/Hc9jpn0ljEc


# Copy in the files to the .ssh folder
mkdir /root/.ssh
chmod 700 /root/.ssh


cp /vagrant/foreman-scripts/rsa-public-and-private-keys/id_rsa.pub /root/.ssh/id_rsa.pub
chmod 644 /root/.ssh/id_rsa.pub

cp /vagrant/foreman-scripts/rsa-public-and-private-keys/authorized_keys /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys


exit 0
