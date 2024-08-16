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
[student@control ansible]$ ﻿wget http://content.example.com/Rhce/user_list.yml
[student@control ansible]$ vim user_list.yml
---
users:
  - name: david
    job: developer
  - name: nancy
    job: manager
  - name: haley
    job: developer 

:wq
```
output: \
![image](https://github.com/user-attachments/assets/01b5fd2b-2feb-4f9a-a274-11118e3cd88e)

2) Edit the "users.yml" playbook:
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
       when: item.job =='developer'
       loop: "{{ users }}"


- name: create manager users
  hosts: prod
  vars_file:
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
       when: item.job=='manager'
       loop: "{{ users }}"

:wq      
```

3) Test and run the "hosts.yml" playbook:
```
[student@control ansible]$ ansible-navigator run -m stdout hosts.yml -C
<output omitted>
[student@control ansible]$ ansible-navigator run -m stdout hosts.yml
```
output: \
![image](https://github.com/user-attachments/assets/850a704e-ad58-41f6-8a2e-70a2060113dc)

4) Finally, you may validate using the "ansible all -m command -a 'getent group opsdev'" and the same for opsmgr: \
output: \
![image](https://github.com/user-attachments/assets/3c312b57-aa6d-418a-8ee9-16a4d02ae14d)

* Done!!

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
cat << EOF > ~/ansible-files/roles/requirements.yml
---
- src: https://github.com/bbatsche/Ansible-PHP-Site-Role.git
  name: phpinfo

- src: https://github.com/geerlingguy/ansible-role-haproxy.git
  name: balancer
EOF

# 10. Install the roles using the requirements.yml:
ansible-galaxy install -r requirements.yml -p ~/ansible-files/roles --ignore-errors



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
```
[Back to Top](#Create-a-users-playbook)
