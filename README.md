vagrant-foreman


### Pre-reqs

you need to have the following installed on your host machine:

* virtualbox
* packer
* vagrant


### Pre-reqs (optional)

you need to create 2 directories under these locations:

* C:\vagrant-personal-files
* C:\packer

copy your .gitconfig file into the vagrant-personal-files directory
git clone under the packer directory 


### Set up

cd into the project folder and run the following to create the 2 ".box"" files

```sh
$ packer build master.json
$ packer build agent.json
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


### Auto snapshots

On accasions you'll want to reset your vagrant boxes. This is usually done by doing "vagrant destroy" followed by "vagrant up". This can be timeconsuming. A much faster approach is to use virtualbox snapshots instead. 


For each vm, a virtualbox is taken towards the end of your "vagrant up". This snapshot is called "baseline". If you want to roll back to this snapshot, then you do:

```
vagrant snapshot go puppetmaster baseline
```

...or for a puppetagent, e.g. puppetagent01, you do:

```
vagrant snapshot go puppetagent01 baseline
```