#!/bin/bash
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