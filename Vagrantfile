# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.define :node01 do |node01|
    node01.vm.hostname = "node01"
    node01.vm.network :private_network, ip: '192.168.50.10'
    node01.vm.provision "shell", path: "postinstall-node01.sh"
  end

  config.vm.define :node02 do |node02|
    node02.vm.hostname = "node02"
    node02.vm.network :private_network, ip: '192.168.50.11'
    node02.vm.provision "shell", path: "postinstall-node02.sh"
  end

  config.vm.define :manager do |manager|
    manager.vm.hostname = "manager"
    manager.vm.network :private_network, ip: '192.168.50.15'
    manager.vm.provision "shell" do |s|
      s.path = "postinstall-manager.sh"
      s.args = ["192.168.50.10", "192.168.50.11"]
    end
  end
end