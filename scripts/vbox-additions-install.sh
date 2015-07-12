#!/bin/bash
# A better alternative to this script is let vagrant do this for you via: 
# the vagrant-vbguest https://github.com/dotless-de/vagrant-vbguest
# This means that people using different versions of virtualbox are not stuck
# with an incompatible guest-additions version that is preinstalled.


echo "#####################################################################"
echo "#################INSTALLING GUEST ADDITIONS##########################"
echo "#####################################################################"
# Mount the disk image


mkdir /tmp/isomount
mount -t iso9660 -o loop /root/VBoxGuestAdditions.iso /tmp/isomount


# Install the drivers
/tmp/isomount/VBoxLinuxAdditions.run

# Cleanup
umount isomount
rm -rf isomount /root/VBoxGuestAdditions.iso
 
echo "#####################################################################"
echo "#################FINISHED INSTALLING GUEST ADDITIONS#################"
echo "#####################################################################"