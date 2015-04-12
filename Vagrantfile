# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "ubuntu/trusty64"

  config.vm.network "forwarded_port", guest: 4000, host: 4000
  config.vm.network "public_network", bridge: 'wlp3s0'

  config.vm.synced_folder ".", "/vagrant", type: "rsync", rsync__exclude: [".git/", "_site/"]

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
   config.ssh.forward_agent = true

  config.vm.provision "shell", inline: "sudo apt-get -y update && sudo apt-get -y install build-essential ruby1.9.3 && sudo gem install therubyracer jekyll"
  
end
