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
   * Create a static inventory file called /home/rhel/ansible-files/inventory as follows:
          -- node1 is a member of dev host group.
          -- node2 is a member of test host group.
          -- node3 and node4 are the members of the prod host group.
          -- node5 is a member of the balancers host group.
          -- The prod group is a member of the webservers group.

   * Create a configuration file called /home/rhel/ansible-files/ansible.cfg so that:
          -- The host inventory file should be defined as /home/rhel/ansible-files/inventory
          -- The default roles directory is /home/rhel/ansible-files/roles
          -- The default content collections directory is /home/rhel/ansible-files/mycollections

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
[rhel@control ~]# yum clean all
[rhel@control ~]# yum install -y ansible python3-pip container-tools
```

2) Next, install and run ANSIBLE-NAVIGATOR (ONLY INSTALL ON CONTROL NODE):
```
[rhel@control ~]# exit
[rhel@control ~]$ python3 -m pip install ansible-navigator --user
[rhel@control ~]$ ansible-navigator
<output omitted>

# It will begin pulling down the container execution environment and it will execute the process.
```

3) Now, we need to create the two folders for roles and collections:
```
for i in {roles,mycollections,host_vars,group_vars}; do mkdir -p /home/rhel/ansible-files/${i}
```

4) Next, you need to edit the inventory file:
```
[rhel@control ~]$ cd ansible
[rhel@control ansible]$ vim inventory

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
[rhel@control ansible]$ vim ansible.cfg

[defaults]
remote_user=rhel
inventory=/home/rhel/ansible-files/inventory
roles_path=/home/rhel/ansible-files/roles
collections_path=/home/rhel/ansible-files/mycollections
ask_pass=false
host_key_checking=false
callbacks_enabled=profile_tasks

[privilege_escalation]
become=true
become_medthod=sudo
become_user=root
become_ask_pass=false

:wq
```

5) We need to create the ssh-keys:
```
ssh-keygen -t rsa -b 4096 -N ""
```

6) Then distribute them to the nodes for the rhel user:
```
vim authorized_keys.yml

---
- name: set rhel authorized keys
  hosts: all
  become: false
  tasks:
    - name: ensure that .ssh directory is there
      ansible.builtin.file:
        path: /home/rhel/.ssh
        state: directory
        mode: '0700'
        owner: rhel
        group: rhel

    - name: Set authorized key taken from file
      ansible.posix.authorized_key:
        user: rhel
        state: present
        key: "{{ lookup('file', '/home/rhel/.ssh/id_rsa.pub') }}"
```

7) Run the playbook:
```
ansible-navigator run -m stdout authorized_keys.yml --ask-pass
```

8) We can ping to see if our nodes respond:
```
[rhel@control ansible]$ ansible all -m ping
```

* Done!!

[Continue to the Next Lab](02_repo_yml_(MEDIUM).md#Start-Here)

</br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br>
## OPTIONAL SETTINGS
10) It's advised to set your ~/.vimrc to auto indent yaml file types:
```
[rhel@control ansible]$ vim ~/.vimrc

autocmd FileType yaml setlocal ai ts=2 sw=2 et cuc cul

:wq
```

10) We can choose to list our hosts to validate our inventory file:
```
[rhel@control ansible]$ ansible all --list-hosts
  hosts (5):
    node1
    node2
    node5
    node3
    node4
[rhel@control ansible]$ ansible-navigator inventory -i inventory -m stdout --graph
<output omitted>
```

11) We may configure ansible-navigator:
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

12) Lastly for our lab, we need to set the /etc/fstab to automount /dev/sr0 to /media:
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


