<a href="https://www.youtube.com/watch?v=R8uwRtgkmCQ&list=PLYB6dfdhWDePZf4fd4YgGGtSX_vHKv5vz&index=2">Video Tutorial</a> by Teach Me Tech \
<a href="https://www.youtube.com/watch?v=0HNuR1a6-9M&list=PLL_setXLS0tiYMipvQI4oUGkJwhOhn42J">Video Tutorial</a> by CodeXchange (BEST)

***On the Control Node***

# Configure Ansible
### QUESTION #1:
```
Instructions:

control node: 
              control.example.com     172.28.128.100/24

managed nodes:
              node1.example.com       172.28.128.101/24
              node2.example.com       172.28.128.102/24
              node3.example.com       172.28.128.103/24
              node4.example.com       172.28.128.104/24
              node5.example.com       172.28.128.105/24

1. Install and configure Ansible on control node as follows:

   * Install the required packages.
   * Create a static inventory file called /home/student/ansible/inventory as follows:
          -- node1 is a member of dev host group.
          -- node2 is a member of test host group.
          -- node3 and node4 are the members of the prod host group.
          -- node5 is a member of the balancers host group.
          -- The prod group is a member of the webservers group.

   * Create a configuration file called /home/student/ansible/ansible.cfg so that:
          -- The host inventory file should be defined as /home/student/ansible/inventory
          -- The default roles directory is /home/student/ansible/roles
          -- The default content collections directory is /home/student/ansible/mycollections

   * The topography will be as follows:


                                       +---------------------+
                                       |       control       |
                                       | control.example.com |
                                       |    172.28.128.100   |
                                       +----------+----------+
        __________________________________________|________________________________________
       /                      /                   |                  \                     \
+------+---------+   +-------+--------+   +-------+--------+   +------+---------+   +-------+--------+
|     node1      |   |     node2      |   |     node3      |   |     node4      |   |     node5      |
| 172.28.128.101 |   | 172.28.128.102 |   | 172.28.128.103 |   | 172.28.128.104 |   | 172.28.128.105 |
+----------------+   +----------------+   +----------------+   +----------------+   +----------------+
```

(scroll down for an answer)
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>

### ANSWER #1:

1) First, install ANSIBLE-CORE, PYTHON3-PIP, and CONTAINER-TOOLS on the CONTROL NODE:
```
[ansible@control ~]# yum clean all
[ansible@control ~]# yum install -y ansible python3-pip container-tools
```

2) Next, install and run ANSIBLE-NAVIGATOR (ONLY INSTALL ON CONTROL NODE):
```
[ansible@control ~]# exit
[ansible@control ~]$ python3 -m pip install ansible-navigator --user
[ansible@control ~]$ ansible-navigator
<output omitted>

# It will begin pulling down the container execution environment and it will execute the process.
```

3) Now, we need to create the two folders for roles and collections:
```
[ansible@control ~]$ mkdir -p /home/student/ansible/roles
[ansible@control ~]$ mkdir -p /home/student/ansible/mycollections
```

4) Next, you need to edit the inventory file:
```
[student@control ~]$ cd ansible
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

4) Then, configure Ansible:
```
[student@control ansible]$ vim ansible.cfg

[defaults]
remote_user=student
inventory=/home/student/ansible/inventory
roles_path=/home/student/ansible/roles
collections_path=/home/student/ansible/mycollections
ask_pass=false
host_key_checking=false

[privilege_escalation]
become=true
become_medthod=sudo
become_user=root
become_ask_pass=false

:wq
```

5) As a test, you can run ANSIBLE --VERSION:
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
[student@control ansible]$ ansible-navigator inventory -i inventory -m stdout --graph
<output omitted>
```

7) We can ping to see if our nodes respond:
```
[student@control ansible]$ ansible all -m ping
```

8) Optionally, we may configure ansible-navigator:
```
vim ansible-navigator.yml
---
ansible-navigator:
execution-environment:
 image: ghcr.io/ansible/creator-ee:v0.14.1
 pull:
  policy: missing
playbook-artifact:
 enable: false
```

9) Optionally, we may also configure our ~/.vimrc file so that there is automatic indentation:
```
vim ~/.vimrc

syntax on
set bg=dark
autocmd Filetype yaml setlocal ai et ts=2 sw=2 cuc cul

:wq
```

10) Lastly for our lab, we need to set the /etc/fstab to automount /dev/sr0 to /media:
```
vim fstab.yml

---
- name: Ensure fstab entry exists
  hosts: all
  become: true
  tasks:
    - name: Ensure /media mount point exists
      file:
        path: /media
        state: directory

    - name: Ensure fstab entry for /dev/sr0 exists
      lineinfile:
        path: /etc/fstab
        line: '/dev/sr0  /media    iso9660    defaults 0 0'
        state: present
        create: yes
    - name: Reload systemd to apply changes
      command: systemctl daemon-reload

    - name: Mount all filesystems in fstab
      command: mount -a

:wq
```

[Continue to the next lab](#
