node "mists.evaryont.me" {
  group { 'users':
    ensure => 'present',
    gid    => '100',
  }

  user { 'colin':
    ensure  => 'present',
    comment => 'Colin\'s Admin Account' ,
    gid     => '100',
    groups  => ['wheel', 'log'],
    home    => '/home/colin',
    shell   => '/bin/zsh',
    uid     => '2000',
    require => Group['users'],
  }
}
