# -*- mode: ruby -*-
# vi: set ft=ruby :


# http://stackoverflow.com/questions/19492738/demand-a-vagrant-plugin-within-the-vagrantfile
required_plugins = %w( vagrant-hosts vagrant-share vagrant-vbguest vagrant-vbox-snapshot vagrant-host-shell )
plugins_to_install = required_plugins.select { |plugin| not Vagrant.has_plugin? plugin }
if not plugins_to_install.empty?
  puts "Installing plugins: #{plugins_to_install.join(' ')}"
  if system "vagrant plugin install #{plugins_to_install.join(' ')}"
    exec "vagrant #{ARGV.join(' ')}"
  else
    abort "Installation of one or more plugins has failed. Aborting."
  end
end



Vagrant.configure(2) do |config|
  # The "puppetmaster" string is the name of the box. hence you can do "vagrant up puppetmaster"
  config.vm.define "puppetmaster" do |puppetmaster_config|
    puppetmaster_config.vm.box = "master.box"
    
	# this set's the machine's hostname. 
	puppetmaster_config.vm.hostname = "puppetmaster.local"  

	# this let's you access the machine httpd service from the host machine.
	# puppetmaster_config.vm.network "forwarded_port", guest:80, host:8080
	# puppetmaster_config.vm.network "forwarded_port", guest:443, host:8443
	
	# This will appear when you do "ip addr show". You can then access your guest machine's website using "http://192.168.50.4"
	# Note this is an alternative to the port forwarding approach that we commented out above. 
	puppetmaster_config.vm.network "private_network", ip: "192.168.50.10"  
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
	  vb.name = "foreman-puppetmaster"    
    end
	puppetmaster_config.vm.provision "shell", path: "scripts/foreman-install.sh"
	puppetmaster_config.vm.provision "shell", path: "scripts/install-mcollective-client.sh"
	puppetmaster_config.vm.provision "shell", path: "scripts/install-gems.sh"
	puppetmaster_config.vm.provision "shell", path: "scripts/update-git.sh"
	puppetmaster_config.vm.provision "shell", path: "scripts/install-git-review.sh"
	
	# this takes a vm snapshot (which we have called "basline") as the last step of "vagrant up". 
	puppetmaster_config.vm.provision :host_shell do |host_shell|
      host_shell.inline = 'vagrant snapshot take puppetmaster baseline'
    end
	
  end
    
  config.vm.define "puppetagent01" do |puppetagent_config|
    puppetagent_config.vm.box = "agent.box"
	puppetagent_config.vm.hostname = "puppetagent01.local"  
	puppetagent_config.vm.network "private_network", ip: "192.168.50.11"  
    puppetagent_config.vm.provider "virtualbox" do |vb|
      vb.gui = false
      vb.memory = "1024"
	  vb.cpus = 1
	  vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
	  vb.name = "puppetagent01"    
    end
    puppetagent_config.vm.provision "shell", path: "scripts/install-puppet-agent.sh"
	
	# this takes a vm snapshot (which we have called "basline") as the last step of "vagrant up". 
	puppetagent_config.vm.provision :host_shell do |host_shell|
      host_shell.inline = 'vagrant snapshot take puppetagent01 baseline'
    end
	
  end
  
  # this line relates to the vagrant-hosts plugin, https://github.com/oscar-stack/vagrant-hosts
  # it adds entry to the /etc/hosts file. 
  # this block is placed outside the define blocks so that it gts applied to all VMs that are defined in this vagrantfile. 
  config.vm.provision :hosts do |provisioner|
    provisioner.add_host '192.168.50.10', ['puppetmaster', 'puppetmaster.local']  
    provisioner.add_host '192.168.50.11', ['puppetagent01', 'puppetagent01.local']	
  end
  
  
end
