# Rules to apply to the firewall at the end. All of these rules are indexed
# 900-999.
class myfirewall::post {
  Firewall {
    before => undef,
  }
  firewall { '905 reject closed TCP with RST':
    proto  => 'tcp',
    action => 'reject',
    reject => 'tcp-rst'
  }->
  firewall { '905 reject closed UDP with ICMP unreachable':
    proto  => 'udp',
    action => 'reject',
    reject => 'icmp-port-unreachable'
  }->
  firewall { '990 reject all remaining traffic':
    action => 'reject',
    reject => 'icmp-port-unreachable'
  }
}
