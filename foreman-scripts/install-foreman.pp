#foreman class
#
# USAGE
# This class is intended to be applied locally using the "puppet apply" rather than "puppet agent -t". 
# This manifest needs to be applied on a vm that has internet access
# 
  

class foreman{


  package { 'install foreman repos':
    name     => 'foreman-release',
    ensure   => 'present',
    source   => 'http://yum.theforeman.org/releases/1.8/el6/x86_64/foreman-release.rpm',
    provider => rpm,
  }

  package { 'install puppetlabs repos':
    name   => 'puppetlabs-release',
    ensure => 'present',
    source => 'http://yum.theforeman.org/releases/1.8/el6/x86_64/foreman-release.rpm',
  }

  package { 'install epel repos':
    name     => 'epel-release',
    ensure   => 'present',
    source   => 'http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm',
    provider => rpm,
  }

  package { 'foreman-installer':
    ensure  => 'present',
    require => [
      Package['install foreman repos'], 
      Package['install puppetlabs repos'],
      Package['install epel repos'],
    ],            
  }

  exec {'install foreman':
    command => '/usr/sbin/foreman-installer --foreman-admin-username=admin --foreman-admin-password=password',
    unless  => '/sbin/service foreman status',
    require => Package['foreman-installer'],
    timeout => 0,
  }

  exec {'configure foreman':
    command => '/usr/sbin/foreman-installer \
      --foreman-admin-username=admin \
      --foreman-admin-password=password \
      --no-enable-foreman-compute-ec2 \
      --no-enable-foreman-compute-gce \
      --no-enable-foreman-compute-libvirt \
      --no-enable-foreman-compute-openstack \
      --no-enable-foreman-compute-rackspace \
      --enable-foreman-compute-vmware \
      --enable-foreman-plugin-bootdisk \
      --enable-foreman-plugin-default-hostgroup \
      --no-enable-foreman-plugin-discovery \
      --enable-foreman-plugin-docker \
      --enable-foreman-plugin-hooks \
      --enable-foreman-plugin-setup \
      --enable-foreman-plugin-templates \
      --foreman-proxy-realm-provider=false \
      --foreman-proxy-tftp-listen-on=both \
      --foreman-proxy-dhcp-managed=false  \
      --foreman-proxy-tftp-syslinux-root=/usr/share/syslinux \
      --foreman-proxy-puppetca=true',
    subscribe => Exec['install foreman'],
    unless  => '/sbin/service foreman status',
    timeout => 0,
  }

}
include foreman
