# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "arch-box"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = 'https://downloads.sourceforge.net/project/vagrant-archlinux/vagrant-archlinux.box'

  config.vm.provider :virtualbox do |vb|
    # Expand the VM's memory to 2GB, matching my VPS
    vb.customize ["modifyvm", :id, "--memory", "2048"]
  end

  # The Mists is the proving/testing ground of my network. See
  # http://wiki.guildwars2.com/wiki/The_Mists
  config.vm.provision :shell, :inline => "hostnamectl set-hostname mists.evaryont.me"
  
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "site.pp"
    puppet.options        = "--verbose --debug"
  end

  config.vm.synced_folder ".", "/vagrant", disabled: true
end
