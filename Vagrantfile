# -*- mode: ruby -*-
# vi: set ft=ruby :
load 'parameters.rb'

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "precise32"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"

  config.vm.provider :virtualbox do |vb|
    vb.name = "wp-from-backup"
    vb.customize ["modifyvm", :id, "--memory", 1024]
  end

  config.vm.network :forwarded_port, guest: @params[:local_port], host: @params[:local_port]
  config.vm.provision :shell, :path => "provision.sh"
end
