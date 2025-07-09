* Be sure to check out the [README](https://github.com/RedHatRanger/RHCE9Vagrant/blob/main/README.md)

# Choose your START POINT:
## I. Red Hat Interactive Labs:
### 1. <a href="https://developers.redhat.com/learning/learn:ansible:yaml-essentials-ansible/resource/resources:hands-interactive-lab-and-helpful-resources">Link to the Hands-on Interactive lab by Red Hat</a>, Then Goto [Start Point](#Start-Point)
### 2. Skip to [Lab #7 - packages.yml](07_packages_yml_(EASY).md)
### 3. Skip to [Lab #8 - webcontent.yml](08_webcontent_yml_(MEDIUM).md)
### 4. Skip to [Lab #9 - hwreport.yml](09_hwreport_yml_(HARD).md)
### 5. Skip to [Lab #10 - issue.yml](10_issue_yml_(EASY).md)
### 6. Skip to [Lab #11 - hosts.yml](11_hosts_yml_(MEDIUM).md)
### 7. Skip to [Lab #12 - locker.yml](12_locker_yml_(EASY).md)
### 8. Skip to [Lab #13 - users.yml](13_users_yml_(HARD).md)
### 9. Skip to [Lab #14 - rekey vault.yml](14_rekey_vault_pw_(EASY).md)
### 10. Skip to [Lab #15 - crontab.yml](15_crontab_yml_(EASY).md)
### 11. Skip to [Lab #16 - lv.yml](16_lv_yml_(HARD).md)
### 12. Skip to [Lab #17 - timesync.yml](17_timesysnc_yml_(MEDIUM).md)
### 13. Skip to [Lab #18 - selinux.yml](18_selinux_roles_(MEDIUM).md)
### 14. Skip to [Lab #19 - motd.yml](19_motd_yml_(EASY).md)

</br></br>
OR....
## II. Virtualbox Home Lab:
### 1. [Continue Setting Up Ansible Yourself on Virtualbox VMs](01_configure_ansible_(MEDIUM).md#configure-ansible)


</br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br>
</br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br>

## Start Point
```
### Copy and paste these lines of code to setup your system in a flash ### --CLICK THE TWO SQUARES HERE TO COPY THIS CODE-->>>

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
```
### CONGRATULATIONS, You Have Configured Ansible...Your Destiny Awaits HERE:
[Continue to the next lab](03_install_collections_(EASY).md)
