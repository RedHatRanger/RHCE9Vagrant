<a href="https://www.youtube.com/watch?v=R8uwRtgkmCQ&list=PLYB6dfdhWDePZf4fd4YgGGtSX_vHKv5vz&index=2">Video Tutorial</a> by Teach Me Tech


***On the Control Node***

# Setup Ansible Inventory
### QUESTION #1:
```
Instructions:

1. Install and configure Ansible on control node as follows:
a) install the required packages.
b) create static inventory file called /home/student/ansible/inventory as follows:
   i)   node1 is a member of dev host group.
   ii)  node2 is a member of test host group.
   iii) node3 and node4 are the members of the prod host group.
   iv)  node5 is a member of the balancers host group.
c) The prod group is a member of the webservers group.
d) Create a configuration file called /home/student/ansible/ansible.cfg so that:
   i)   The host inventory file should be defined as /home/student/ansible/inventory
   ii)  The default content collections directory is /home/student/ansible/mycollections
   iii) The default roles directory is /home/student/ansible/roles
```

(scroll down for an answer)
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>

### ANSWER #1:

* First, install ANSIBLE-CORE, PYTHON3-PIP, and CONTAINER-TOOLS on the CONTROL NODE:
```
[ansible@control ~]# yum clean all
[ansible@control ~]# yum install -y ansible-core python3-pip container-tools
```

* Next, install and run ANSIBLE-NAVIGATOR (ONLY INSTALL ON CONTROL NODE):
```
[ansible@control ~]# pip install ansible-navigator
[ansible@control ~]# ansible-navigator
<output omitted>

# It will begin pulling down the container execution environment and it will execute the process.
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

3) Then, configure Ansible:
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

4) As a test, you can run ANSIBLE --VERSION:
```
[student@control ansible]$ ansible --version
ansible [core 2.12.2]
  config file = /home/student/ansible/ansible.cfg
  configured module search path = ['/home/student/.ansible/plugins/modules', '/usr/share/ansible/plu
gins/modules']
  ansible python module location = /usr/lib/python3.9/site-packages/ansible
  ansible collection location = /home/student/ansible/mycollections
  executable location = /usr/bin/ansible
  python version = 3.9.10 (main, Feb 9 2022, 00:00:00) [GCC 11.2.1 20220127 (Red Hat 11.2.1-9)]
  jinja version = 2.11.3
  libyaml = True
[student@control ansible]$
```

5) VERY IMPORTANT - It's advised to set your ~/.vimrc to auto indent yaml file types:
```
[student@control ansible]$ vim ~/.vimrc

autocmd FileType yaml setlocal ai ts=2 sw=2 et cuc nu

:wq
```

6) We can choose to list our hosts to validate our inventory file:
```
[student@control ansible]$ ansible all --list-hosts
  hosts (5):
    node1
    node2
    node5
    node3
    node4
[student@control ansible]$
```

7) Lastly, we need to use the ping module to see if our nodes respond:
```
[student@control ansible]$ ansible all -m ping

node1 | SUCCESS => {
    "ansible_facts": {
          "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
node3 | SUCCESS => {
    "ansible_facts": {
          "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
node2 | SUCCESS => {
    "ansible_facts": {
          "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
node4 | SUCCESS => {
    "ansible_facts": {
          "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
node5 | SUCCESS => {
    "ansible_facts": {
          "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
```
