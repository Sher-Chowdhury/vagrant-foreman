#!/bin/bash

# note this is a truth table syntax, which is a type of if-statement. 
cp -f /vagrant/personal-data/hiera.yaml /etc/puppet/hiera.yaml 2>/dev/null || exit 0


if [ ! -d /vagrant/personal-data/GitServerCertificates ]; then
  exit 0
fi 

#Enable ‘Shared System Certificates’ feature
update-ca-trust enable

#Copy .pem certificate files 
cp -rf /vagrant/personal-data/GitServerCertificates/*.pem /etc/pki/ca-trust/source/anchors/

# Update the trusted certificates
update-ca-trust

# if the above has worked, then you should now be able to also use secure "https" links, i.e. you should now be able to do:
# $ git clone https://...  
# as well as being able to do:
# $ git clone https://...  