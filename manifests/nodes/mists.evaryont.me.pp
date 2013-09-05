node 'mists.evaryont.me' inherits 'common' {
  group { 'users':
    ensure => present,
    gid    => '100',
  }

  user { 'colin':
    ensure  => present,
    comment => 'Colin\'s Admin Account' ,
    gid     => '100',
    groups  => ['wheel', 'log'],
    home    => '/home/colin',
    shell   => '/bin/zsh',
    uid     => '2000',
    require => Group['users'],
  }

  # I dislike yaourt, so remove it from the system.
  package { 'yaourt':
    ensure => absent
  }

  package { 'net-tools':
    ensure => present
  }

  package { 'lsb-release':
    ensure => present
  }

  package { 'augeas':
    ensure => present
  }

  package { 'ruby-augeas':
    ensure   => present,
    provider => 'gem',
    require  => Package['augeas'],
  }
}
