<a href="https://www.youtube.com/watch?v=UkAhDPc--eI&list=PLL_setXLS0tiYMipvQI4oUGkJwhOhn42J&index=7">Video Tutorial</a> by codeXchange

### NOTE: If you ran out of time, or are close to running out of time on the RED HAT OFFICIAL LAB, [Click Here](#Catch-Up)

***On the Control Node***

# Install Packages in Muliple Groups
### QUESTION #7:
```
Instructions:

7. Install packages in multiple groups
i) Install vsftpd and mariadb-server packages in dev and test group.
ii) Install "RPM Development Tools" group package in prod group.
iii) Update all packages in dev group.
iv) Use separate play for each task and playbook name should be packages.yml.
```

(scroll down for an answer)
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>

### ANSWER #7:

1) Log into the CONTROL NODE as student, and create the packages.yml file:
```
[student@control ansible]$ vim packages.yml

---
- name: packages installation
  hosts: dev,test
  tasks:
     - name: installing vsftpd and mariadb-server packages
       ansible.builtin.dnf:
           name:
              - vsftpd
              - mariadb-server
           state: present

- name: group package installation
  hosts: prod
  tasks:
     - name: Installing "RPM Development Tools" group package
       ansible.builtin.dnf:
           name: "@RPM Development Tools"
           state: present

- name: update all packages
  hosts: dev
  tasks:
     - name: updating all packages
       ansible.builtin.dnf:
           name: "*"
           state: latest

:wq
```

2) Run the packages.yml playbook:
```
[student@control ansible]$ ansible-navigator run -m stdout packages.yml
```
output:
![image](https://github.com/user-attachments/assets/afb234ed-1729-42ec-ae86-0452be2af6d5)

* Done!!

<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>

## Catch Up
```
### Copy and paste these lines of code to setup your system in a flash ### --CLICK THE TWO SQUARES HERE TO COPY THIS CODE-->>>

# 1. Change the directory to the ansible working directory:
echo "cd ~/ansible-files" >> ~/.bashrc
echo "alias nav='ansible-navigator run -m stdout'" >> ~/.bashrc
echo "alias task='ansible -m shell -a'" >> ~/.bashrc; . ~/.bashrc

# 2. Create the inventory file:
cat << EOF > inventory
[dev]
node1

[test]
node2

[prod]
node3

[balancers]
node3

[webservers:children]
prod
EOF

# 3. Create the ansible.cfg:

cat << EOF > ansible.cfg
[defaults]
remote_user=rhel
inventory=/home/rhel/ansible-files/inventory
roles_path=/home/rhel/ansible-files/roles
collections_path=/home/rhel/ansible-files/mycollections
ask_pass=false
host_key_checking=false
callbacks_enabled=profile_tasks

[ssh_connection]
pipelining=true

[privilege_escalation]
become=true
become_method=sudo
become_user=root
become_ask_pass=false
EOF

# 4. Create our directories on the Ansible controller:
for i in {templates,roles,mycollections,group_vars,host_vars}; do mkdir -p /home/rhel/ansible-files/${i}; done

# 5. Download and install the two collections from Ansible Galaxy (ignore errors):
ansible-galaxy collection install ansible.posix 2>/dev/null
ansible-galaxy collection install community.general 2>/dev/null

# 6. Install the "rhel-system-roles":
sudo yum install rhel-system-roles -y

# 7. Create a sample "file.yml" for debugging purposes:
cat << EOF > file.yml
---
# ansible-navigator run -m stdout file.yml

- name: run tasks on all hosts
  hosts: all
  tasks:
    - name: debug the system
      ansible.builtin.debug:
        var: ansible_host
EOF

# 8. Create a "defaults.yml" file inside the "group_vars" folder:
cat << EOF > group_vars/defaults.yml
---
ansible_user: rhel
ansible_python_interpreter: /usr/bin/python3
EOF

# 9. Setup the Roles/Requirements.yml:
cat << EOF > ~/ansible-files/roles/requirements.yml
---
- src: https://github.com/bbatsche/Ansible-PHP-Site-Role.git
  name: phpinfo

- src: https://github.com/geerlingguy/ansible-role-haproxy.git
  name: balancer
EOF

# 10. Install the roles using the requirements.yml:
ansible-galaxy install -r requirements.yml -p ~/ansible-files/roles --ignore-errors
```

