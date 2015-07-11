# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure(2) do |config|
  # The "puppetmaster" string is the name of the box. hence you can do "vagrant up puppetmaster"
  config.vm.define "puppetmaster" do |puppetmaster_config|
    puppetmaster_config.vm.box = "centos7.box"
    
	# this set's the machine's hostname. 
	puppetmaster_config.vm.hostname = "puppet.master"  

	# this let's you access the machine httpd service from the host machine.
	puppetmaster_config.vm.network "forwarded_port", guest:80, host:8888
	
	puppetmaster_config.vm.network "private_network", ip: "192.168.50.4"

    puppetmaster_config.vm.provider "virtualbox" do |vb|
      # Display the VirtualBox GUI when booting the machine
      vb.gui = true
      
      # Customize the amount of memory on the VM:
      vb.memory = "1024"
 
      # name of machine that appears on the vb console and vb consoles title. 	  
	  vb.name = "centos7-foreman"   
	
      vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]  
    end
    
	
	puppetmaster_config.vm.provision "shell", path: "scripts/foreman-install.sh"
	
	
  end
  
end
