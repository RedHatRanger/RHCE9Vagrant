<a href="https://www.youtube.com/watch?v=7-hhX6rcuvY&list=PLYB6dfdhWDePZf4fd4YgGGtSX_vHKv5vz&index=12">Video Tutorial</a> by Teach Me Tech \
<a href="https://www.youtube.com/watch?v=m5KhsZonGBY&list=PLL_setXLS0tiYMipvQI4oUGkJwhOhn42J&index=9">Video Tutorial</a> by codeXchange \
<a href="https://www.youtube.com/watch?v=8gOgJbQ29Bc">Video Tutorial</a> by Silent Solution (BEST)


### NOTE: If you ran out of time on the RED HAT OFFICIAL LAB, [Click Here](#Catch-Up) 

</br></br>
***On the Control Node***

# Create a hwreport
### QUESTION #9:
```
Instructions:

9. Collect a hardware report using a playbook on all nodes.
  i)   Download "hwreport.txt" from the url "http://content.example.com/hwreport.txt" and save it under /root.
  ii)  If there is no information it should show "NONE"
  iii) The name of the laybook should be "hwreport.yml"


                                    *** NOTE ***:
For this example we will download the file from:
https://raw.githubusercontent.com/RedHatRanger/RHCE9Vagrant/main/rhce-practice-questions/golden_files/hwreport.txt

/root/hwreport.txt should have content with node information as key=value
#hwreport
HOSTNAME=
MEMORY=
BIOS=
DISK_SIZE_SDA=
DISK_SIZE_SDB=
```

(scroll down for an answer)
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>

### ANSWER #9:
MODULES USED:
- get_url
- replace
- You will use "ansible-doc get_url" and "ansible-doc replace" for the syntax

</br></br>

1) Create the "hwreport.yml" file:
```
# NOTE: If you are unsure you can run "ansible-doc get_url" and search /EXAMPLES for Download foo.conf
# AND "ansible all -m setup > test" will get you the correct parameters you are looking for the replace: option.

[rhel@control ansible]$ vim hwreport.yml
```
```yaml
---
# ansible-navigator run -m stdout hwreport.yml
- name: Generate a hw report
  hosts: all
  tasks:
    - name: Download foo.conf
      ansible.builtin.get_url:
        url: https://raw.githubusercontent.com/RedHatRanger/RHCE9Vagrant/main/rhce-practice-questions/golden_files/hwreport.txt
        dest: /root/hwreport.txt
        mode: '0755'

    - name: Replace old hostname with new hostname (requires Ansible >= 2.4)
      ansible.builtin.replace:
        path: /root/hwreport.txt
        regexp: "{{ item.oldinfo }}"
        replace: "{{ item.newinfo }}"
      loop:
        - oldinfo: "inventoryhostname"
          newinfo: "{{ ansible_hostname | default ('NONE') }}"
        - oldinfo: "memory_in_MB"
          newinfo: "{{ ansible_memory_mb.real.free | default ('NONE') }}"
        - oldinfo: "BIOS_version"
          newinfo: "{{ ansible_bios_version | default ('NONE') }}"
        - oldinfo: "disk_sda_size"
          newinfo: "{{ ansible_devices.sda.size | default ('NONE') }}"
        - oldinfo: "disk_sdb_size"
          newinfo: "{{ ansible_devices.sdb.size | default ('NONE') }}"
```

2) Test and run the hwreport.yml playbook:
```
[rhel@control ansible]$ ansible-navigator run -m stdout hwreport.yml
```

* Validate the /root/hwreport.txt file for each of the nodes:
```
[rhel@control ansible]$ ansible all -m shell -a "cat /root/hwreport.txt; echo ' '"
```

* Done!!
</br></br>

[Continue to the Next Lab](10_issue_yml_(EASY).md)

<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>

## Catch Up
### 1. <a href="https://developers.redhat.com/learning/learn:ansible:yaml-essentials-ansible/resource/resources:hands-interactive-lab-and-helpful-resources">Link to the Hands-on Interactive lab by Red Hat</a>, Then Continue Below
```
### Copy and paste these lines of code to setup your system in a flash ### --CLICK THE TWO SQUARES HERE TO COPY THIS CODE-->>>
#################################################### BEGIN SETUP ###########################################################
# 0. Set the ~/.vimrc file:
cat << EOF >> ~/.vimrc
abbr _dnf ansible.builtin.dnf:
abbr _svc ansible.builtin.service:
abbr _rule ansible.posix.firewalld:
abbr _tmp ansible.builtin.template:
abbr _file ansible.builtin.file:
abbr _cp ansible.builtin.copy:
abbr _url ansible.builtin.get_url:
abbr _rp ansible.builtin.replace:
abbr _usr ansible.builtin.user:
abbr _grp ansible.builtin.group:
EOF

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

##################################################### LAB #3 #######################################################
# 9. Install the two collections
cd ~/ansible-files
ansible-galaxy collection install https://galaxy.ansible.com/download/ansible-posix-1.5.4.tar.gz -p mycollections/
ansible-galaxy collection install https://galaxy.ansible.com/download/community-general-9.2.0.tar.gz -p mycollections/

####################################################### LAB #4 #######################################################
# 10. Setup the Roles/Requirements.yml:
cd ~/ansible-files
cat << EOF > /home/rhel/ansible-files/roles/requirements.yml
---
- src: https://github.com/RedHatRanger/phpinfo.git
  name: phpinfo

- src: https://github.com/RedHatRanger/balancer.git
  name: balancer
EOF

# 10. Install the roles using the requirements.yml:
ansible-galaxy install -r /home/rhel/ansible-files/roles/requirements.yml -p ~/ansible-files/roles --ignore-errors


####################################################### LAB #5 #######################################################
# 11. Change Directory to the roles directoy and generate the offline role:
cd ~/ansible-files/roles
ansible-galaxy role init --offline apache

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
  hosts: webservers
  roles:
    - apache
EOF

ansible-navigator run -m stdout apache_role.yml

# 15. Curl test node3:
curl http://node3


##################################################### LAB #6 ########################################################
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

# Commented out to save time in the Interactive Labs:
#- name: update dev packages
#  hosts: dev
#  tasks:  
#    - name: update dev packages
#      dnf:
#        name: "*"
#        state: latest
EOF

ansible-navigator run -m stdout packages.yml


##################################################### LAB #8 #######################################################
cd ~/ansible-files
cat << EOF > webcontent.yml
---
# ansible-navigator run -m stdout webcontent.yml

- name: none for now
  hosts: webservers
  tasks:
    - name: create a /webdev direectory
      file:
        path: /webdev
        state: directory
        group: wheel
        mode: 2775
        setype: httpd_sys_content_t

    - name: create symbolic link
      file:
        src: /webdev
        dest: /var/www/html/webdev
        state: link
        force: yes
    
    - name: copy using inline content
      copy:
        content: "Development"
        dest: /webdev/index.html
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
curl http://node3/webdev/index.html
echo -e "\n"
```
[Back to Top](#Create-a-hwreport)
