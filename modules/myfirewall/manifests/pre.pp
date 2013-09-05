# Rules to apply to the beginnig of every system's firewall chain. The rules are
# indexed 000-100, no higher.
class myfirewall::pre {
  Firewall {
    require => undef,
  }

  # The namevar for firewallchain is in the format chain_name:table:protocol.
  # The 5 built-in tables in iptables on Linux are filter, nat, mangle, raw and
  # security. See iptables(8) for more information, but we mostly only care
  # about IPv4 traffic in the filter table. (Unless we are doing routing things,
  # like a VPN or rouer, in which nat is useful as well.)

  # Create TCP & UDP chains
  firewallchain { 'TCP:filter:IPv4':
    ensure => present,
  }
  firewallchain { 'UDP:filter:IPv4':
    ensure => present,
  }

  firewallchain { 'INPUT:filter:IPv4':
    ensure => present,
    policy => 'drop'
  }
  firewallchain { 'FORWARD:filter:IPv4':
    ensure => present,
    policy => 'drop'
  }
  firewallchain { 'OUTPUT:filter:IPv4':
    ensure => present,
    policy => 'accept'
  }


  # Default firewall rules
  firewall { '000 accept related & established connections':
    ctstate => ['RELATED', 'ESTABLISHED'],
    action  => 'accept'
  }->
  firewall { '001 accept all traffic on loopback':
    iniface => 'lo',
    action  => 'accept',
  }->
  firewall { '002 drop invalid incoming connections':
    ctstate => ['INVALID'],
    action  => 'drop'
  }->
  firewall { '003 allow new ICMP echos (ping)':
    proto   => 'icmp',
    icmp    => 8,
    ctstate => ['NEW'],
    action  => 'accept'
  }->
  firewall { '004 send UDP traffic to UDP chain':
    proto   => 'udp',
    ctstate => ['NEW'],
    jump    => 'UDP'
  }->
  firewall { '004 send TCP traffic to TCP chain':
    proto   => 'tcp',
    ctstate => ['NEW'],
    jump    => 'TCP'
  }->
  firewall { '012 allow SSH (port 22)':
    proto  => 'tcp',
    dport  => [22],
    action => 'accept',
    chain  => 'TCP'
  }

}
