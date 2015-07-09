# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure(2) do |config|

  config.vm.define "puppetmaster" do |puppetmaster|
    puppetmaster.vm.box = "centos7.box"
    
    puppetmaster.vm.provider "virtualbox" do |vb|
      # Display the VirtualBox GUI when booting the machine
      vb.gui = true
      
      # Customize the amount of memory on the VM:
      vb.memory = "1024"
    
      vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
    end
    
  end
  
end
