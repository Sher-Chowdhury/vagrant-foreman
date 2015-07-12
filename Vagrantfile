# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure(2) do |config|
  # The "puppetmaster" string is the name of the box. hence you can do "vagrant up puppetmaster"
  config.vm.define "puppetmaster" do |puppetmaster_config|
    puppetmaster_config.vm.box = "centos7.box"
    
	# this set's the machine's hostname. 
	puppetmaster_config.vm.hostname = "puppet.master"  

	# this let's you access the machine httpd service from the host machine.
	# puppetmaster_config.vm.network "forwarded_port", guest:80, host:8080
	# puppetmaster_config.vm.network "forwarded_port", guest:443, host:8443
	
	
	# This will appear when you do "ip addr show". You can then access your guest machine's website using "http://192.168.50.4"
	# Note this is an alternative to the port forwarding approach that we commented out above. 
	puppetmaster_config.vm.network "private_network", ip: "192.168.50.4"  
	# note: this approach works as long as you assign special internal ip addresses. In which case virtualbox's builtin router reroutes the traffic to the 
	# guest vms.....see: https://en.wikipedia.org/wiki/Private_network 
	

    puppetmaster_config.vm.provider "virtualbox" do |vb|
      # Display the VirtualBox GUI when booting the machine
      vb.gui = true
      
      # For common vm settings, e.g. setting ram and cpu we use:
      vb.memory = "1024"
	  vb.cpus = 2
	  
	  # However for more obscure virtualbox specific settings we fall back to virtualbox's "modifyvm" command:
	  vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
 
      # name of machine that appears on the vb console and vb consoles title. 	  
	  vb.name = "centos7-foreman"   
	  
        
    end
    
	
	puppetmaster_config.vm.provision "shell", path: "scripts/foreman-install.sh"
	
	
  end
  
end
