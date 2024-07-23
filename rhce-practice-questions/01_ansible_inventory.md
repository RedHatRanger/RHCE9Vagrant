<a href="https://www.youtube.com/watch?v=R8uwRtgkmCQ&list=PLYB6dfdhWDePZf4fd4YgGGtSX_vHKv5vz&index=2">Video Tutorial</a> by Teach Me Tech


***On the Control Node***

# Setup Ansible Inventory
### QUESTION #1:
```
Instructions:

control node: control.example.com

managed nodes:
              node1.example.com
              node2.example.com
              node3.example.com
              node4.example.com
              node5.example.com
* All nodes root password is "redhat" and Ansible control node username is student with passowrd "redhat".

* create directory "ansible" under path /home/student/ and all playbooks should be under /home/student/ansible.

* all playbooks should be owned by student and ansible managed node username is also student.

* Unless advised password should be "redhat" for all the users.

Ansible Automation Platform (AAP) 2.2 is utility.example.com credentials are admin, redhat.

Note: In exam, if they have not given managed node username, in that case, user control node user as remote user.
-------------------------------------------------------------------------------------
# ssh student@workstation

1. Install and configure ansible on control node as follows:
    * install the required package
    * create static inventory file called /home/student/ansible/inventory as follows:

- node1.example.com is a member of dev host group
- node2.example.com is a member of test host group
- node3.example.com is a member of prod host group
- node4.example.com is a member of balancers host group
- the prod group is a member of the webservers host group

* Create a configuration file called ansible.cfg as follows:
- the host inventory file should be defined as /home/student/ansible/inventory
- the location of roles used in playbooks should be as /home/student/ansible/roles
- the location of collections used in playbooks should be as /home/student/ansible/collections
```

(scroll down for an answer)
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>

### ANSWER #1:

1) Log into the CONTROL NODE as student, and edit the ansible.cfg file:
```
[student@control ~]$ cd ~/ansible
[student@control ansible]$ vim ansible.cfg

[defaults]
remote_user=student
inventory=/home/student/ansible/inventory
roles_path=/home/student/ansible/roles
collections_path=/home/student/ansible/mycollections
ask_pass=false

[privilege_escalation]
become=true
become_medthod=sudo
become_user=root
become_ask_pass=false

:wq
```

2) Next, you need to edit the inventory file:
```
[student@control ansible]$ vim inventory

[dev]
node1

[test]
node2

[prod]
node3
node4

[balancers]
node5

[webservers:children]
prod

:wq
```
