<a href="https://www.youtube.com/watch?v=KX8eu8PsTy4&list=PLYB6dfdhWDePZf4fd4YgGGtSX_vHKv5vz&index=16">Video Tutorial</a> by Teach Me Tech \
<a href="https://www.youtube.com/watch?v=HIAX4gQx94U&list=PLL_setXLS0tiYMipvQI4oUGkJwhOhn42J&index=13">Video Tutorial</a> by codeXchange (BEST)
</br></br>

### NOTE: If you ran out of time on the RED HAT OFFICIAL LAB, [Click Here](#Catch-Up) 
</br></br>

***On the Control Node***

## Create a users playbook
### QUESTION #13:
```
Instructions:

﻿13. Download the variable file
"http://content.example.com/Rhce/user_list.yml" and write a playbook named "users.yml" and then run the playbook
on all the nodes using two variable files user_list.yml and vault.yml.

i)  * Create a group opsdev
    * Create user from users varaible who job is equal to developer and need to be in opsdev group
    * Assign a password using SHA512 format and run playbook on dev and test group.
    * User password is {{ pw_developer }}

ii) * Create a group opsmgr
    * Create user from users varaible who job is equal to manager and need to be in opsmgr group
    * Assign a password using SHA512 format and run playbook on test group.
    * User password is {{ pw_manager }}

iii) Use when condition for each play
```

(scroll down for an answer)
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>

### ANSWER #13:
MODULES USED:
- user
- group


</br></br>
1) Log into the CONTROL NODE as student, and run "wget" to download the "user_list.yml" file:
```
cd ~/ansible-files
wget https://raw.githubusercontent.com/RedHatRanger/RHCE9Vagrant/main/rhce-practice-questions/golden_files/user_list.yml

[student@control ansible]$ cat user_list.yml
---
users:
  - name: david
    job: developer
  - name: nancy
    job: manager
  - name: haley
    job: developer 
```

2) Create the "users.yml" playbook:
```
---
- name: create developer users
  hosts: dev,test
  vars_files:
    - user_list.yml
    - vault.yml
  tasks:
    - name: create opsdev group
      group:
        name: opsdev
        state: present

    - name: add users who have developer job
      user:
        name: "{{ item.name }}"
        groups: opsdev
        password: "{{ pw_developer | password_hash('sha512') }}"
      when: item.job == 'developer'
      loop: "{{ users }}"


- name: create manager users
  hosts: prod
  vars_files:
    - user_list.yml
    - vault.yml
  tasks:
    - name: create opsmgr group
      group:
        name: opsmgr
        state: present

    - name: add users who have manager job
      user:
        name: "{{ item.name }}"
        groups: opsmgr
        password: "{{ pw_manager | password_hash('sha512') }}"
      when: item.job == 'manager'
      loop: "{{ users }}"
```

3) Test and run the "users.yml" playbook:
```
ansible-navigator run -m stdout users.yml
```

4) Finally, you may validate:
```
ansible all -m shell -a "getent group opsdev"
```

```
ansible all -m shell -a "getent group opsdev"
```

* Done!!
</br></br>
[Continue to the next lab](14_rekey_vault_pw_(EASY).md)

<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>

## Catch Up
### 1. <a href="https://developers.redhat.com/learning/learn:ansible:yaml-essentials-ansible/resource/resources:hands-interactive-lab-and-helpful-resources">Link to the Hands-on Interactive lab by Red Hat</a>, Then Continue Below
```
### Copy and paste these lines of code to setup your system in a flash ### --CLICK THE TWO SQUARES HERE TO COPY THIS CODE-->>>
#################################################### BEGIN SETUP ###########################################################
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
####################################################### END SETUP ####################################################

####################################################### LAB #3 #######################################################
# 9. Setup the Roles/Requirements.yml:
cd ~/ansible-files
cat << EOF > /home/rhel/ansible-files/roles/requirements.yml
---
- src: https://github.com/bbatsche/Ansible-PHP-Site-Role.git
  name: phpinfo

- src: https://github.com/geerlingguy/ansible-role-haproxy.git
  name: balancer
EOF

# 10. Install the roles using the requirements.yml:
ansible-galaxy install -r /home/rhel/ansible-files/roles/requirements.yml -p ~/ansible-files/roles --ignore-errors



####################################################### LAB #4 #######################################################
# 11. Change Directory to the roles directoy and generate the offline role:
cd ~/ansible-files/roles
ansible-galaxy init --offline apache

# 12. Write the template.j2 file:
cd apache/templates/
cat << EOF > template.j2
Welcome to {{ ansible_fqdn }} ON {{ ansible_default_ipv4.address }}
EOF

# 13. Create the Role's tasks main.yml file:
cd ~/ansible-files/roles/apache/tasks/
cat << EOF > main.yml
---
# tasks file for apache
- name: install httpd and firewalld
  ansible.builtin.dnf:
    name:
      - httpd
      - firewalld
    state: latest

- name: start both services
  ansible.builtin.service:
    name: "{{ item }}"
    state: restarted
    enabled: yes
  loop:
    - httpd
    - firewalld

- name: add http service to the firewall rule
  ansible.posix.firewalld:
    service: http
    state: enabled
    permanent: yes
    immediate: yes

- name: copy the template.j2 file to the webserver directory
  ansible.builtin.template:
    src: template.j2
    dest: /var/www/html/index.html
EOF

# 14. Create the apache_role.yml file, and run it in ansible-navigator:
cd ~/ansible-files
cat << EOF > apache_role.yml
---
- name: use apache role
  hosts: dev
  roles:
    - apache
EOF

ansible-navigator run -m stdout apache_role.yml

# 15. Curl test node1:
curl http://node1


##################################################### LAB #5 ########################################################
# 16. Create and run roles.yml:
cd ~/ansible-files
cat << EOF > roles.yml
---
- hosts: webservers
  roles:
    - phpinfo
- hosts: balancers
  roles:
    - balancer
EOF

# NOTE: YOU WILL HAVE TO FIX THE NGINX problem:
sed -i '/dependencies.*/,$d' /home/rhel/ansible-files/roles/phpinfo/meta/main.yml
ansible-navigator run -m stdout roles.yml &>/dev/null
# ON THE TEST THIS WILL WORK IF YOU TRY CURLING THE DIFFERENT MACHINES


##################################################### LAB #6 #######################################################
# 17. Install the two collections
cd ~/ansible-files
ansible-galaxy collection install https://galaxy.ansible.com/download/ansible-posix-1.5.4.tar.gz -p mycollections/
ansible-galaxy collection install https://galaxy.ansible.com/download/community-general-9.2.0.tar.gz -p mycollections/


##################################################### LAB #7 #######################################################
# 18. Multi-Packages Installation
cd ~/ansible-files
cat << EOF > packages.yml
---
# ansible-navigator run -m stdout packages.yml

- name: install packages
  hosts: dev,test
  tasks:  
    - name: yum install vsftpd and mariadb packages in dev and test
      dnf:
        name:
          - vsftpd
          - mariadb-server
        state: present

- name: install group packages
  hosts: prod
  tasks:  
    - name: yum install group package on prod group
      dnf: 
        name: "@RPM Development Tools"
        state: present

- name: update dev packages
  hosts: dev
  tasks:  
    - name: update dev packages
      dnf:
        name: "*"
        state: latest
EOF

ansible-navigator run -m stdout packages.yml


##################################################### LAB #8 #######################################################
# 19. webcontent
cd ~/ansible-files
cat << EOF > webcontent.yml
---
# ansible-navigator run -m stdout webcontent.yml

- name: none for now
  hosts: dev
  tasks:
    - name: create a /devweb direectory
      file:
        path: /devweb
        state: directory
        group: wheel
        mode: 2775
        setype: httpd_sys_content_t

    - name: create symbolic link
      file:
        src: /devweb
        dest: /var/www/html/devweb
        state: link
        force: yes
    
    - name: copy using inline content
      copy:
        content: "Development"
        dest: /devweb/index.html
        setype: httpd_sys_content_t
    
    - name: allow http traffic
      ansible.posix.firewalld:
        service: http
        permanent: true
        immediate: true
        state: enabled
EOF

ansible-navigator run -m stdout webcontent.yml
echo -e "\n"
curl http://node1/devweb/index.html
echo -e "\n"

##################################################### LAB #9 #######################################################
# 20. hwreport
cd ~/ansible-files
cat << EOF > hwreport.yml
---
- name: Generate a hardware report
  hosts: all
  become: true
  tasks:
    - name: Get the file from the url
      ansible.builtin.get_url:
        url: https://raw.githubusercontent.com/RedHatRanger/RHCE9Vagrant/main/rhce-practice-questions/golden_files/hwreport.txt
        dest: /root/hwreport.txt
        mode: '0755'

    - name: Generate information for the Inventory hostname
      ansible.builtin.replace:
        path: /root/hwreport.txt
        regexp: "inventoryhostname"
        replace: "{{ ansible_hostname | default ('NONE') }}"

    - name: Generate information for memory_in_MB
      ansible.builtin.replace:
        path: /root/hwreport.txt
        regexp: "memory_in_MB"
        replace: "{{ ansible_memory_mb.real.free | default ('NONE') }}"

    - name: Generate information for BIOS_version
      ansible.builtin.replace:
        path: /root/hwreport.txt
        regexp: "BIOS_version"
        replace: "{{ ansible_bios_version | default ('NONE') }}"

    - name: Generate information for disk_sda_size
      ansible.builtin.replace:
        path: /root/hwreport.txt
        regexp: "disk_sda_size"
        replace: "{{ ansible_devices.sda.size | default ('NONE') }}"

    - name: Generate information for disk_sdb_size
      ansible.builtin.replace:
        path: /root/hwreport.txt
        regexp: "disk_sdb_size"
        replace: "{{ ansible_devices.sdb.size | default ('NONE') }}"
EOF

ansible-navigator run -m stdout hwreport.yml


##################################################### LAB #10 #######################################################
# 21. issue.yml
cd ~/ansible-files
cat << EOF > issue.yml
---
- name: Configure /etc/issue content based on environment
  hosts: dev
  tasks:
    - name: copy using inline content
      ansible.builtin.copy:
          content: "Development"
          dest: /etc/issue

- name: content in prod hosts prod
  hosts: prod
  tasks:
    - name: copy using inline content
      ansible.builtin.copy:
          content: "Production"
          dest: /etc/issue

- name: content in dev
  hosts: test
  tasks:
    - name: copy using inline content
      ansible.builtin.copy:
          content: "Test"
          dest: /etc/issue
EOF

ansible-navigator run -m stdout issue.yml


##################################################### LAB #11 #######################################################
# 22. hosts.yml
cd ~/ansible-files
cat << EOF > myhosts.j2
127.0.0.1 localhost localhost.localdomain localhost4 localhost4.localdomain4
::1 localhost localhost.localdomain localhost6 localhost.localdomain6

{% for host in groups['all'] %}
{{ hostvars[host].ansible_default_ipv4.address }} {{ hostvars[host].ansible_fqdn }} {{ hostvars[host].ansible_hostname }}
{%endfor%}
EOF

cat << EOF > hosts.yml
---
- name: Copy from template
  hosts: all
  tasks:
    - name: use template
      ansible.builtin.template:
        src: myhosts.j2
        dest: /etc/myhosts

- name: Remove /etc/myhosts from everything but dev
  hosts: all,!dev
  tasks:
    - name: delete from all
      ansible.builtin.file:
        path: /etc/myhosts
        state: absent
EOF

ansible-navigator run -m stdout hosts.yml


##################################################### LAB #12 #######################################################
# 23. vault.yml
cd ~/ansible-files
cat << EOF > secret.txt
P@ssw0rd
EOF

# Write the YAML content to the file first
cat << EOF > vault.yml
pw_developer: Iamdev
pw_manager: Iammgr
EOF

# Encrypt the file with ansible-vault using the password in secret.txt:
ansible-vault encrypt vault.yml --vault-password-file=secret.txt

# View the contents:
ansible-vault view vault.yml --vault-password-file=secret.txt
```
[Back to Top](#Create-a-users-playbook)
