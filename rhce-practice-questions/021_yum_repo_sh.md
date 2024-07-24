<a href="https://www.youtube.com/watch?v=3zV89O7azb0&list=PLYB6dfdhWDePZf4fd4YgGGtSX_vHKv5vz&index=3">Video Tutorial</a> by Teach Me Tech \
<a href="https://www.youtube.com/watch?v=iCWa4Me0ykM">Video Tutorial</a> by Nehra Classes

***On the Control Node***

# Configure the repository on all nodes
### QUESTION #2:
```
Instructions:

2. Create and run an Ansible ad-hoc command.  As a system administrator, you will need to install software on the managed nodes:
a) Create a shell script called yum-repo.sh that runs Ansible ad-hoc commands to create the yum repositories
   on each of the managed nodes as per the following details:
b) NOTE: you need to create 2 repos (BaseOS & AppStream) in the managed nodes.
BaseOS:
name: BaseOS
baseurl: file:///mnt/BaseOS/
description: Base OS Repo
gpgcheck: no
enabled: yes
AppStream:
name: AppStream
baseurl: file:///mnt/AppStream/
description: AppStream Repo
gpgcheck: no
enabled: yes
```

(scroll down for an answer)
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>

### ANSWER #2:

1) Log into the CONTROL NODE as student, and create/edit a yum_repo.yml file:
```
[student@control ansible]$ vim yum_repo.yml

---
- name: configure yum
  hosts: all
  tasks:
     - name: configure AppStream
       ansible.builtin.yum_repository:
           name: "Applications"
           description: "Apps"
           baseurl: file:///media/AppStream
           enabled: yes
           gpgcheck: 0
           # gpgcheck: http://content......

     - name: configure BaseOS
       ansible.builtin.yum_repository:
           name: "OperatingSystem"
           description: "BaseOS"
           baseurl: file:///media/BaseOS
           enabled: yes
           gpgcheck: 0
           # gpgcheck: http://content......

:wq
```

2) Configure the ANSIBLE-NAVIGATOR settings, so you don't have to type the "ansible-playbook run -m stdout <playbook>.yml" each time:
```
vim ~/ansible/ansible-navigator.yml

ansible-navigator:
  mode: stdout

:wq
```

4) WE RUN THE PLAYBOOK:
```
[student@control ansible]$ ansible-navigator run yum_repo.yml
<output omitted>
```

4) Finally, we clean the current repos on all the nodes FROM THE CONTROL NODE, then gather the repolists:
```
[student@control ansible]$ ansible all -m command -a "yum clean all"
<output omitted>

[student@control ansible]$ ansible all -m command -a "yum repolist all"
node3 | CHANGED | rc=0 >>
Updating Subscription Management repositories.
Unable to read consumer identity
This system is not registered with an entitlement server. You can use subscription-manager to regist
er.
repo id                           repo name                      status
Applications                      Apps                           enabled
BaseOS                            OperatingSystem                enabled
node4 | CHANGED | rc=0 >>
Updating Subscription Management repositories.
Unable to read consumer identity
This system is not registered with an entitlement server. You can use subscription-manager to regist
er.
repo id                           repo name                      status
Applications                      Apps                           enabled
BaseOS                            OperatingSystem                enabled
node2 | CHANGED | rc=0 >>
Updating Subscription Management repositories.
Unable to read consumer identity
This system is not registered with an entitlement server. You can use subscription-manager to regist
er.
repo id                           repo name                      status
Applications                      Apps                           enabled
BaseOS                            OperatingSystem                enabled
node5 | CHANGED | rc=0 >>
Updating Subscription Management repositories.
Unable to read consumer identity
This system is not registered with an entitlement server. You can use subscription-manager to regist
er.
repo id                           repo name                      status
Applications                      Apps                           enabled
BaseOS                            OperatingSystem                enabled
nodel | CHANGED | rc=0 >>
Updating Subscription Management repositories.
Unable to read consumer identity
This system is not registered with an entitlement server. You can use subscription-manager to regist
er.
repo id                           repo name                      status
Applications                      Apps                           enabled
BaseOS                            OperatingSystem                enabled
```

* Done!!
