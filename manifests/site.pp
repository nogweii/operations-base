import "nodes/*.pp"

# The single parent for all nodes. Make sure all the node blocks includes
# "inherits 'common'".
node 'common' {
  include concat::setup
  include stdlib::stages

  if ($operatingsystem == 'Archlinux') {
    include pacman
  }
}
