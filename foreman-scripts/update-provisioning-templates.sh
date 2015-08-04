#!/bin/bash
# https://github.com/theforeman/foreman_templates
# https://puppetmaster.local/config_templates

yum -y install ruby193-rubygem-foreman_templates  >/dev/null

foreman-rake templates:sync  


hammer template delete --name "Alterator default" 
hammer template delete --name "Alterator default finish"
hammer template delete --name 'Alterator default PXELinux'
hammer template delete --name 'alterator_pkglist'
hammer template delete --name 'AutoYaST default'
hammer template delete --name 'AutoYaST default PXELinux'
hammer template delete --name 'AutoYaST SLES default'
hammer template delete --name 'coreos_cloudconfig'
hammer template delete --name 'CoreOS provision'
hammer template delete --name 'CoreOS PXELinux'
hammer template delete --name 'epel'
hammer template delete --name 'fix_hosts'
hammer template delete --name 'FreeBSD (mfsBSD) finish'
hammer template delete --name 'FreeBSD (mfsBSD) provision'
hammer template delete --name 'FreeBSD (mfsBSD) PXELinux'
hammer template delete --name 'freeipa_register'
hammer template delete --name 'Grubby default'
hammer template delete --name 'Jumpstart default'
hammer template delete --name 'Jumpstart default finish'
hammer template delete --name 'Jumpstart default PXEGrub'
hammer template delete --name 'Junos default SLAX'
hammer template delete --name 'Junos default ZTP config'
hammer template delete --name 'Kickstart default'
hammer template delete --name 'Kickstart default finish'
hammer template delete --name 'Kickstart default iPXE'
hammer template delete --name 'Kickstart default PXELinux'
hammer template delete --name 'Kickstart default user data'
hammer template delete --name 'kickstart_networking_setup'
hammer template delete --name 'Kickstart RHEL default'
hammer template delete --name 'Preseed default'
hammer template delete --name 'Preseed default finish'
hammer template delete --name 'Preseed default iPXE'
hammer template delete --name 'Preseed default PXELinux'
hammer template delete --name 'Preseed default user data'
hammer template delete --name 'puppet.conf'
hammer template delete --name 'PXEGrub default local boot'
hammer template delete --name 'PXELinux default local boot'
hammer template delete --name 'PXELinux default memdisk'
hammer template delete --name 'PXELinux global default'
hammer template delete --name 'redhat_register'
hammer template delete --name 'saltstack_minion'
hammer template delete --name 'UserData default'
hammer template delete --name 'WAIK default PXELinux'
hammer template delete --name 'Junos default finish'
#hammer template delete --name 'Boot disk iPXE - generic host'
#hammer template delete --name 'Boot disk iPXE - host'
#hammer template delete --name 'http_proxy'

foreman-rake templates:sync repo="http://SChowdhury@stash.ordsvy.gov.uk/scm/~schowdhury/os-foreman-provisioning-templates.git"

exit 0


