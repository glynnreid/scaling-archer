# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

	config.vm.provider :virtualbox do |vb|
  # Don't boot with headless mode
		vb.gui = false
    # Use VBoxManage to customize the VM. For example to change memory:
    vb.customize ["modifyvm", :id, "--memory", "2048"]
  end
	
	config.vm.provision :shell, :path => "app/scripts/bootstrap.sh"
	
	config.vm.network :forwarded_port, host: 8888, guest: 80
	config.vm.network :forwarded_port, host: 33063, guest: 3306

end
