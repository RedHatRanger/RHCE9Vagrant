1) <a href=https://developer.hashicorp.com/vagrant/install>Download and Install Vagrant</a>
2) <a href=https://m.majorgeeks.com/files/details/vmware_workstation_for_windows.html>Download VMWare workstation for Windows</a>
3) <a href=https://developer.hashicorp.com/vagrant/install/vmware>Download and install the VMWare Vagrant Package</a>
4) Run these commands in PowerShell:
```
mkdir ~\vagrant
cd ~\vagrant
```

* Copy the Vagrantfile to this folder and then run these commands:
```
vagrant plugin install vagrant-vmware-desktop
vagrant up --provider=vmware_workstation
```
