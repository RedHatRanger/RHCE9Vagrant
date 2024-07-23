### THE SETUP ###

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
gpgcheck=0

[AppStream]
name=BaseOS
baseurl=file:///run/media/ansible/RHEL-9-4-BaseOS-x86_64/AppStream
enabled=1
gpgcheck=0

:wq
```

* First, install ANSIBLE-CORE, PYTHON3-PIP, and CONTAINER-TOOLS:
```
[ansible@control ~]# yum clean all
[ansible@control ~]# yum install -y ansible-core python3-pip container-tools
```

* Next, install ANSIBLE-NAVIGATOR:
```
[ansible@control ~]# pip install ansible-navigator
```
