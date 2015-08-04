vagrant-foreman


### Pre-reqs

you need to have the following installed on your host machine:

* [virtualbox](https://www.virtualbox.org/)  
* [packer](https://www.packer.io/)
* [vagrant](https://www.vagrantup.com/)
* [git-bash](https://msysgit.github.io/)

Once they are all installed, do the following:

1. right click on the virtualbox icon, 
2. go to properties, 
3. select on shortcut tab
4. click on the "advanced" button
5. enable the "Run as Administrator" checkbox and save changes
6. Repeat the above steps, but this time for Git bash, You can find this icon under, start -> All programs -> git -> Git Bash 

### Pre-reqs (optional, but recommended)

Open up a git-bash terminal and: 

* run the ssh-keygen command on your host machine (if you havent done this in past already). 
* run the following to enter your credentials:
```
$ git config --global user.name "John Doe"
$ git config --global user.email johndoe@example.com
```


### Set up

Start a git-bash terminal

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