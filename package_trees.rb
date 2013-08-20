require 'yaml'
require 'puppet'

# Quick script to get all of the package resources Puppet is managing, gets the
# package tree (the packages it depends on, and those they depend on, and so
# on). Useful to compare to the output of `pacman -Qq`, which lists all
# installed packages. If there are any changes, well, that means there are
# packages installed that Puppet isn't managing, which is probably a no-no.

# cd to where the reports are being stored
Dir.chdir '/var/lib/puppet/reports/mists.evaryont.me/'
# get the latest reports
latest_report = Dir['*'].sort_by{ |f| File.mtime(f) }.last
# And load it
report = YAML.load_file(latest_report)

puppet_tree = Tempfile.new('puppet')
pacman_tree = Tempfile.new('pacman')

puppet_packages = report.resource_statuses.keys.grep(/^Package\[/).map do |package|
  package_name = report.resource_statuses[package].title

  `pactree -u #{package_name} 2>/dev/null`.split("\n").map do |line|
    line.split(' ')[0]
  end
end.flatten.uniq.sort.join("\n")

puppet_tree.write puppet_packages
puppet_tree.close

pacman_tree.write `pacman -Qq`
pacman_tree.close

system("diff -u #{pacman_tree.path} #{puppet_tree.path}")
