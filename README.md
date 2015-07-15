centos7-packer-virtualbox-foreman


### Pre-reqs

you need to have the following installed on your host machine:

* virtualbox
* packer
* vagrant
* vagrant plugin: vagrant-hosts
* vagrant plugin: vagrant-vbguest



### Set up


cd into the project folder and run the following to create the 2 ".box"" files

```sh
$ packer centos-dvd-iso-virtualbox.json
$ packer puppetagent-centos6_6-minimal-virtualbox-iso.json
```
Each of the above commands will take about 40mins to complete, but depends on your machine specs and internet connections. 

The Run the following:

```sh
$ vagrant up
``` 





### Set up local rerouting if you are running vagrant on windows machine

Enter this in the windows hosts file (C:\Windows\System32\drivers\etc\hosts):

```
192.168.50.10   puppetmaster puppetmaster.local
192.168.50.11   puppetagent01 puppetagent01.local
```