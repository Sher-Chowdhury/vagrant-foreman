#!/bin/bash
# https://puppetmaster.local/media

hammer medium delete --name 'CentOS mirror'
hammer medium delete --name 'CoreOS mirror'
hammer medium delete --name 'Debian mirror'
hammer medium delete --name 'Fedora mirror'
hammer medium delete --name 'FreeBSD mirror'
hammer medium delete --name 'OpenSUSE mirror'
hammer medium delete --name 'Ubuntu mirror'

exit 0