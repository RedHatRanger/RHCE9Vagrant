<a href="https://www.youtube.com/watch?v=R8uwRtgkmCQ&list=PLYB6dfdhWDePZf4fd4YgGGtSX_vHKv5vz&index=2">Video Tutorial</a> by Teach Me Tech


***On the Control Node***

# Setup Ansible Inventory
### QUESTION #1:
```
Instructions:

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

3) As a test, you can run ANSIBLE --VERSION:
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

4) VERY IMPORTANT - It's advised to set your ~/.vimrc to auto indent yaml file types:
```
[student@control ansible]$ vim ~/.vimrc

autocmd FileType yaml setlocal ai ts=2 sw=2 et cuc nu

:wq
```

5) We can choose to list our hosts to validate our inventory file:
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

6) Lastly, we need to use the ping module to see if our nodes respond:
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
