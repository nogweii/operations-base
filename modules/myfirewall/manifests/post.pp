# Rules to apply to the firewall at the end. All of these rules are indexed
# 900-999.
class myfirewall::post {
  #firewall { '999 drop all':
  #  proto   => 'all',
  #  action  => 'drop',
  #  before  => undef,
  #}
}
