class myfirewall {
  # Delete all firewall stuff that puppet isn't managing
  resources { "firewall":
    purge => true
  }

  Firewall {
    before  => Class['myfirewall::post'],
    require => Class['myfirewall::pre'],
  }

  class { 'firewall':
    ensure => 'running'
  }

}
