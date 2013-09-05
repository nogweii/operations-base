# Security and configuration of pacman, the Arch Linux package manager.
class pacman {
  file { ['/etc/pacman.d', '/etc/pacman.d/gnupg']:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  file { ['/etc/pacman.conf',
          '/etc/pacman.d/gnupg/gpg.conf',
          '/etc/pacman.d/gnupg/pubring.gpg',
          '/etc/pacman.d/gnupg/pubring.gpg~',
          '/etc/pacman.d/gnupg/trustdb.gpg',
          '/etc/pacman.d/mirrorlist']:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => [File['/etc/pacman.d'], File['/etc/pacman.d/gnupg']],
  }

  file { ['/etc/pacman.d/gnupg/random_seed', '/etc/pacman.d/gnupg/secring.gpg']:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    require => File['/etc/pacman.d/gnupg'],
  }

}
