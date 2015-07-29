#!/bin/bash
# https://puppetmaster.local/media

hammer medium delete --name 'CentOS mirror'
hammer medium delete --name 'CoreOS mirror'
hammer medium delete --name 'Debian mirror'
hammer medium delete --name 'Fedora mirror'
hammer medium delete --name 'FreeBSD mirror'
hammer medium delete --name 'OpenSUSE mirror'
hammer medium delete --name 'Ubuntu mirror'


hammer medium create --name "OracleLinux Mirror" --path "http://`hostname -f`/mirror/OracleLinux/OL\$major/\$minor/base/\$arch"

# This gets resolved to numerous paths, here's an example to one of them:
# http://fqdn/mirror/OracleLinux/OL6/6/base/x86_64/

exit 0