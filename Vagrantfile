# -*- mode: ruby -*-
# vi: set ft=ruby :


# http://stackoverflow.com/questions/19492738/demand-a-vagrant-plugin-within-the-vagrantfile
required_plugins = %w( vagrant-hosts vagrant-share vagrant-vbguest vagrant-vbox-snapshot vagrant-host-shell vagrant-triggers vagrant-reload )
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
  ##
  ## PUPPET MASTER
  ##
  # The "puppetmaster" string is the name of the box. hence you can do "vagrant up puppetmaster"
  config.vm.define "puppetmaster" do |puppetmaster_config|
    puppetmaster_config.vm.box = "master.box"
    
	# this set's the machine's hostname. 
	puppetmaster_config.vm.hostname = "puppetmaster.local"  

	
	# This will appear when you do "ip addr show". You can then access your guest machine's website using "http://192.168.50.4" 
	puppetmaster_config.vm.network "private_network", ip: "192.168.50.10"  
	# note: this approach assigns a reserved internal ip addresses, which virtualbox's builtin router then reroutes the traffic to,
	#see: https://en.wikipedia.org/wiki/Private_network 
	
    puppetmaster_config.vm.provider "virtualbox" do |vb|
      # Display the VirtualBox GUI when booting the machine
      vb.gui = true
      
      # For common vm settings, e.g. setting ram and cpu we use:
      vb.memory = "1024"
	  vb.cpus = 2
	  
	  # adding a second hdd to my vm. 
	  # https://gist.github.com/leifg/4713995
	  
	  #   docker_storage = './tmp/docker.vdi'
	  #   unless File.exist?(docker_storage)
      #     vb.customize ['createhd', '--filename', docker_storage, '--size', 50 * 1024]     # This is 50GB, 
      #   end
      #   vb.customize ['storageattach', :id, '--storagectl', 'IDE Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', docker_storage]
	  
	  # this port forwarding is required if you want an external agent (i.e. not a virtualbox puppet agent)
	  # to connect to you puppetmaster. 
	  puppetmaster_config.vm.network "forwarded_port", guest: 8140, host: 8140, protocol: 'tcp'
	  
	  # However for more obscure virtualbox specific settings we fall back to virtualbox's "modifyvm" command:
	  vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
 
      # name of machine that appears on the vb console and vb consoles title. 	  
	  vb.name = "foreman-puppetmaster"    
    end

	# Copy git server related .pem files from the host machine to the guest machine. this is to allow git clone commands to run using https links rather than http. 
	puppetmaster_config.vm.provision :host_shell do |host_shell|
      host_shell.inline = "[ -d /c/vagrant-personal-files/GitServerCertificates ] && cp -rf /c/vagrant-personal-files/GitServerCertificates ./personal-data/GitServerCertificates"
    end
	puppetmaster_config.vm.provision "shell", path: "scripts/copy-GitServerCertificates-into-vm.sh"		

#	puppetmaster_config.vm.provision "shell", path: "scripts/foreman/foreman-install.sh"
	puppetmaster_config.vm.provision "shell", path: "foreman-scripts/master-puppet-run-setup.sh"
	puppetmaster_config.vm.provision "shell", path: "scripts/install-mcollective-client.sh"
#	puppetmaster_config.vm.provision "shell", path: "scripts/install-gems.sh"
#	puppetmaster_config.vm.provision "shell", path: "scripts/update-git.sh"           # no longer using gerrit, so this is obselete
#	puppetmaster_config.vm.provision "shell", path: "scripts/install-git-review.sh"   # no longer using gerrit, so this is obselete
#	puppetmaster_config.vm.provision "shell", path: "docker/install-docker.sh"
	puppetmaster_config.vm.provision "shell", path: "scripts/install-vim-puppet-plugins.sh", privileged: false
#	puppetmaster_config.vm.provision "shell", path: "scripts/setup-puppet-rspec.sh"
	
	# Copy the .gitconfig file from the host machine to the guest machine
 	puppetmaster_config.vm.provision :host_shell do |host_shell|
      host_shell.inline = "cp -f ${HOME}/.gitconfig ./personal-data/.gitconfig"
    end
    puppetmaster_config.vm.provision "shell" do |s| 
 	  s.inline = '[ -f /vagrant/personal-data/.gitconfig ] && runuser -l vagrant -c "cp -f /vagrant/personal-data/.gitconfig ~"'
    end
 
    ## Copy the public+private keys from the host machine to the guest machine
 	puppetmaster_config.vm.provision :host_shell do |host_shell|
      host_shell.inline = "[ -f ${HOME}/.ssh/id_rsa ] && cp -f ${HOME}/.ssh/id_rsa* ./personal-data/"
    end
 	puppetmaster_config.vm.provision "shell", path: "scripts/import-ssh-keys.sh"	
 	
	# Copy the r10k.yaml file from the host machine to the guest machine
	puppetmaster_config.vm.provision :host_shell do |host_shell|
      host_shell.inline = "[ -f /c/vagrant-personal-files/r10k.yaml ] && cp -f /c/vagrant-personal-files/r10k.yaml ./personal-data/r10k.yaml"
    end
	puppetmaster_config.vm.provision "shell", path: "scripts/r10k-run.sh"

	# Copy the hiera.yaml file from the host machine to the guest machine
	puppetmaster_config.vm.provision :host_shell do |host_shell|
      host_shell.inline = "[ -f /c/vagrant-personal-files/hiera.yaml ] && cp -f /c/vagrant-personal-files/hiera.yaml ./personal-data/hiera.yaml"
    end
	puppetmaster_config.vm.provision "shell", path: "scripts/copy-hiera-yaml-file-into-vm.sh"

	
	puppetmaster_config.vm.provision :reload   # this is because foreman's puppetssh feature requires a reboot in order for it to work. 
	
 	# this takes a vm snapshot (which we have called "basline") as the last step of "vagrant up". 
 	puppetmaster_config.vm.provision :host_shell do |host_shell|
      host_shell.inline = 'vagrant snapshot take puppetmaster baseline'
    end
	
  end

  ##
  ## PUPPET AGENTS - linux 7 boxes
  ##  
  (1..2).each do |i|  
    config.vm.define "puppetagent0#{i}" do |puppetagent_config|
      puppetagent_config.vm.box = "agent.box"
      puppetagent_config.vm.hostname = "puppetagent0#{i}.local"  
      puppetagent_config.vm.network "private_network", ip: "192.168.50.1#{i}"  
      puppetagent_config.vm.provider "virtualbox" do |vb|
        vb.gui = false
        vb.memory = "1024"
        vb.cpus = 1
        vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
        vb.name = "puppetagent0#{i}"    
      end
      puppetagent_config.vm.provision "shell", path: "scripts/install-puppet-agent.sh"
      puppetagent_config.vm.provision "shell", path: "foreman-scripts/agent-puppet-run-setup.sh"
      
      # this takes a vm snapshot (which we have called "basline") as the last step of "vagrant up". 
      puppetagent_config.vm.provision :host_shell do |host_shell|
        host_shell.inline = "vagrant snapshot take puppetagent0#{i} baseline"
      end
      
    end
  end
  
  ##
  ## PUPPET AGENTS - Linux 6 boxes
  ##  
  (5..6).each do |i|  
    config.vm.define "puppetagent0#{i}" do |puppetagent_config|
      puppetagent_config.vm.box = "agent6.box"
      puppetagent_config.vm.hostname = "puppetagent0#{i}.local"  
      puppetagent_config.vm.network "private_network", ip: "192.168.50.1#{i}"  
      puppetagent_config.vm.provider "virtualbox" do |vb|
        vb.gui = false
        vb.memory = "1024"
        vb.cpus = 1
        vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
        vb.name = "puppetagent0#{i}"    
      end
      puppetagent_config.vm.provision "shell", path: "scripts/6/install-puppet-agent.sh"
      puppetagent_config.vm.provision "shell", path: "foreman-scripts/agent-puppet-run-setup.sh"
      
      # this takes a vm snapshot (which we have called "basline") as the last step of "vagrant up". 
      puppetagent_config.vm.provision :host_shell do |host_shell|
        host_shell.inline = "vagrant snapshot take puppetagent0#{i} baseline"
      end
      
    end
  end  
  
  # this line relates to the vagrant-hosts plugin, https://github.com/oscar-stack/vagrant-hosts
  # it adds entry to the /etc/hosts file. 
  # this block is placed outside the define blocks so that it gts applied to all VMs that are defined in this vagrantfile. 
  config.vm.provision :hosts do |provisioner|
    provisioner.add_host '192.168.50.10', ['puppetmaster', 'puppetmaster.local']  
    provisioner.add_host '192.168.50.11', ['puppetagent01', 'puppetagent01.local']
    provisioner.add_host '192.168.50.12', ['puppetagent02', 'puppetagent02.local']
    provisioner.add_host '192.168.50.15', ['puppetagent05', 'puppetagent05.local']		
    provisioner.add_host '192.168.50.16', ['puppetagent06', 'puppetagent06.local']	
  end
  
  config.vm.provision :host_shell do |host_shell|
    host_shell.inline = 'hostfile=/c/Windows/System32/drivers/etc/hosts && grep -q 192.168.50.10 $hostfile || echo "192.168.50.10   puppetmaster puppetmaster.local" >> $hostfile'
  end
  
  config.vm.provision :host_shell do |host_shell|
    host_shell.inline = 'hostfile=/c/Windows/System32/drivers/etc/hosts && grep -q 192.168.50.11 $hostfile || echo "192.168.50.11   puppetagent01 puppetagent01.local" >> $hostfile'
  end  

  config.vm.provision :host_shell do |host_shell|
    host_shell.inline = 'hostfile=/c/Windows/System32/drivers/etc/hosts && grep -q 192.168.50.12 $hostfile || echo "192.168.50.12   puppetagent01 puppetagent02.local" >> $hostfile'
  end 

  config.vm.provision :host_shell do |host_shell|
    host_shell.inline = 'hostfile=/c/Windows/System32/drivers/etc/hosts && grep -q 192.168.50.15 $hostfile || echo "192.168.50.15   puppetagent01 puppetagent05.local" >> $hostfile'
  end 

  config.vm.provision :host_shell do |host_shell|
    host_shell.inline = 'hostfile=/c/Windows/System32/drivers/etc/hosts && grep -q 192.168.50.16 $hostfile || echo "192.168.50.16   puppetagent01 puppetagent06.local" >> $hostfile'
  end   
end
