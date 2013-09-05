# A basic wrapper class that defines the base rules for every server. Generic.
# Mostly a copy & paste from the firewall module README.
#
# The firewall rules are sorted based on their initial 3 digit index. This index
# is categorized as the following:
#
#   000-100 -- Initial rules set in myfirewall::pre
#   101-899 -- Per-node settings throughout the puppet manifests.
#   900-999 -- Final rules set in myfirewall::post
class myfirewall {
  # Delete all firewall stuff that puppet isn't managing
  resources { 'firewall':
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
