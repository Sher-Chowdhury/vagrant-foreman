#!/bin/bash
# https://puppetmaster.local/ptables

hammer partition-table delete --name 'AutoYaST entire SCSI disk'
hammer partition-table delete --name 'AutoYaST entire virtual disk'
hammer partition-table delete --name 'Junos default fake'
hammer partition-table delete --name 'AutoYaST LVM'
hammer partition-table delete --name 'CoreOS default fake'
hammer partition-table delete --name 'FreeBSD'
hammer partition-table delete --name 'FreeBSD default fake'
hammer partition-table delete --name 'Jumpstart default'
hammer partition-table delete --name 'Jumpstart mirrored'
hammer partition-table delete --name 'Preseed custom LVM'
hammer partition-table delete --name 'Preseed default'
hammer partition-table delete --name 'Kickstart default'


cd /tmp
git clone http://SChowdhury@stash.ordsvy.gov.uk/scm/~schowdhury/foreman-partition-tables.git

hammer partition-table create --name '2 drives'  --file /tmp/foreman-partition-tables/2drives.erb
hammer partition-table create --name 'default'  --file /tmp/foreman-partition-tables/default.erb
hammer partition-table create --name 'one_partition'  --file /tmp/foreman-partition-tables/one_partition.erb


rm -rf /tmp/foreman-partition-tables


# Still outstanding: associating partition tables to associated, e.g.:
# hammer partition-table add-operatingsystem --name '2 drives' --operatingsystem-id 2 
# I think you can get the os id's/names from this:
# $ hammer os list
#   ---|------------|--------------|-------
#   ID | TITLE      | RELEASE NAME | FAMILY
#   ---|------------|--------------|-------
#   2  | CentOS 6.6 |              | Redhat
#   1  | CentOS 7.1 |              | Redhat
#   ---|------------|--------------|-------
# $ hammer partition-table info  --name '2 drives'
# Id:                13
# Name:              2 drives
# OS Family:
# Operating systems:
#     CentOS 6.6
# Created at:        2015/07/29 14:47:34
# Updated at:        2015/07/29 14:47:34



exit 0
