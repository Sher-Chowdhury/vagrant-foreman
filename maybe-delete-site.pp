node 'puppetagent01.local' {

  yumrepo { 'foreman_repo':
    ensure   => 'present',
    baseurl  => 'http://yum.theforeman.org/releases/1.9/el7/$basearch',
    descr    => 'foreman-repo',
    enabled  => 1,
    gpgcheck => 0,
    before   => Class[::puppet],
  }

  package { 'epel-release':
    ensure => present,
    before => Class[::puppet],
  }

  class { '::puppet':
    server    => true,
    server_ca => false,
  }


  # ensure firewalld service is not running in order for the following to work. 
  class {'::foreman_proxy':
    foreman_base_url => 'https://puppetmaster.local',
    puppet_url       => 'https://puppetagent01.local',
    puppetca         => false,
    tftp             => false,
  }

}
