### THE SETUP ###

## <a href="https://www.youtube.com/watch?v=8Ls56awCJ_U&list=PLYB6dfdhWDePZf4fd4YgGGtSX_vHKv5vz&index=1">Video #1</a> From Teach Me Tech##

* How to Schedule the Exam EX294:
```
==============================================================
https://rhtapps.redhat.com/individualexamscheduler/services/externaluser/login
==============================================================
```

* Hardware Requirements for This Lab Environment:
```
============================================================
In the Exam we will have 6 Vms.

1-  One is controller node
2-  Five Vms will be used as Managed nodes.
============================================================
Finally we need 6 Virtual Machines for the practice.
Let Say,

3-  2 GB Ram is for Each VM   ( 12 GB)
4-  single core CPU with Each VM ( 6 Cores)
5-  Some of Memory/CPU will be taken by Vmware Workstation 
6-  Rest will be taken by Base os that can your Windows 11.
7-  you might live some live applications like zoom/team/meet, whatsapp, Google Drive, One Drive ( CPU and RAM)
=============================================================
What you need at least if you are using laptop with intel CPU.

8-  at least 16 GB ram in laptop
9-  At least corei7, 8th gen (4 Core and 8 MB cache)
10- Storage you must at least SSD or Recommendation is to 300 GB free space on nvme drive)
=============================================================
```

* Download Checklist:
```
=============================================================
Redhat RHCE Ex294-V9 Exam Preparation ( AUG-2024 )
=============================================================
1-  Create RHN/Redhat Login ID:                  Done.
2-  Download ISO Image                           Done.
    https://developers.redhat.com/ (Select Redhat Enterprise Linux ) and download RHEL 9.4
    https://developers.redhat.com/products/rhel/overview

    01-AUG-2024      (your Exam OS version will be RHEL 9.0)

RHEL 9.4 (That's fine no issue)
RHEL 9.0 (That's A good thing to practice but not essential)

3-  Best Hyperviser:
    Vmware Workstation (FREE)                    Done (with Advance features)
--------------------------------------------------------------
Possible Issues: Don't install two hypervisers at the same time (VMWare Workstation and Virtualbox)
```

* Download Links: 
1) <a href=https://developer.hashicorp.com/vagrant/install>Download and Install Vagrant</a> 
2) <a href=https://m.majorgeeks.com/files/details/vmware_workstation_for_windows.html>Download VMWare workstation for Windows</a>
3) <a href=https://developer.hashicorp.com/vagrant/install/vmware>Download and install the VMWare Vagrant Package</a>
4) Run these commands in PowerShell:
```
PS C:\Users\<your_username>> mkdir ~\vagrant
PS C:\Users\<your_username>> cd ~\vagrant

# IMPORTANT: Before you run these two commands, YOU MUST FIRST COPY THE Vagrantfile FROM:
https://github.com/RedHatRanger/RHCE9Vagrant/Vagrantfiles/vmware/Vagrantfile to your ~/vagrant directory.

PS C:\Users\<your_username>\vagrant> vagrant plugin install vagrant-vmware-desktop
PS C:\Users\<your_username>\vagrant> vagrant up --provider=vmware_desktop
```

* Hostname Configuration:
```
ansible control node: 
              control.example.com     172.28.128.100/24

managed nodes:
              node1.example.com       172.28.128.101/24
              node2.example.com       172.28.128.102/24
              node3.example.com       172.28.128.103/24
              node4.example.com       172.28.128.104/24
              node5.example.com       172.28.128.105/24
              
* All nodes root password is "redhat" and Ansible control node username is student with passowrd "redhat".

* create directory "ansible" under path /home/student/ and all playbooks should be under /home/student/ansible.

* all playbooks should be owned by student and ansible managed node username is also student.

* Unless advised password should be "redhat" for all the users.

Ansible Automation Platform (AAP) 2.2 is utility.example.com credentials are admin, redhat.

Note: In exam, if they have not given managed node username, in that case, user control node user as remote user.
-------------------------------------------------------------------------------------
# ssh student@workstation
```

* Once all the nodes are up and the control node is up, ON THE CONTROL NODE:
```
[ansible@control ~]$ ssh-keygen -t rsa -b 4096
[ansible@control ~]$ for i in {1..5}; do ssh-copy-id -i ~/.ssh/id_rsa.pub ansible@172.28.128.10${i}; done
```

* Here you will enter the passowrd "student" for each of the nodes 1-5

* Next, you will setup the repositories (if you are using Red Hat instead of Rocky Linux):
```
[ansible@control ~]$ sudo su
```
```
[ansible@control ~]# vim /etc/yum.repos.d/myrepo.repo

[BaseOS]
name=BaseOS
baseurl=file:///run/media/ansible/RHEL-9-4-BaseOS-x86_64/BaseOS
enabled=1
gpgcheck=1
gpgkey=file:///run/media/ansible/RHEL-9-4-BaseOS-x86_64/RPM-GPG-KEY-redhat-release

[AppStream]
name=BaseOS
baseurl=file:///run/media/ansible/RHEL-9-4-AppStream-x86_64/AppStream
enabled=1
gpgcheck=1
gpgkey=file:///run/media/ansible/RHEL-9-4-AppStream-x86_64/RPM-GPG-KEY-redhat-release

:wq
```

* First, install ANSIBLE-CORE, PYTHON3-PIP, and CONTAINER-TOOLS:
```
[ansible@control ~]# yum clean all
[ansible@control ~]# yum install -y ansible-core python3-pip container-tools
```

* Next, install and run ANSIBLE-NAVIGATOR (ONLY INSTALL ON CONTROL NODE):
```
[ansible@control ~]# pip install ansible-navigator
[ansible@control ~]# ansible-navigator
```

* It will begin pulling down the container execution environment and it will execute the process.
## END OF VIDEO #1 From Teach Me Tech ##
