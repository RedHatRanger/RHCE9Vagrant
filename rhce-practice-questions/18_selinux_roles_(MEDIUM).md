<a href="https://www.youtube.com/watch?v=7fb98SMGOcw&list=PLYB6dfdhWDePZf4fd4YgGGtSX_vHKv5vz&index=9">Video Tutorial</a> by Teach Me Tech (BEST) \
<a href="https://www.youtube.com/watch?v=2u1eNdrGhjE&list=PLL_setXLS0tiYMipvQI4oUGkJwhOhn42J&index=18">Video Tutorial</a> by codeXchange \
<a href="https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/9/html/automating_system_administration_by_using_rhel_system_roles/configuring-selinux-using-system-roles_automating-system-administration-by-using-rhel-system-roles#using-the-selinux-system-role-to-apply-selinux-settings-on-multiple-systems_configuring-selinux-using-system-roles">Link</a> to the Red Hat Documentation

***On the Control Node***

# Create an selinux.yml playbook
### QUESTION #18:
```
Instructions:

18. Create a playbook called selinux.yml and use system roles

 i) set selinux mode as enforcing on all managed nodes
```

(scroll down for an answer)
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>

### ANSWER #18:
- YOU NEED TO READ THE /home/rhel/ansible-files/roles/rhel-system-roles.selinux/README.md
(It will help you with the variable parameters in the yml file you create)
- You will need to install the "rhel-system-roles" package on the control node.
- In my lab, I had to comment out two tasks which prevented the main.yml from running.

</br></br>
1) Log into the CONTROL NODE as rhel, and perform these tasks:
```
[rhel@control ansible-files]$ sudo yum install -y rhel-system-roles
[rhel@control ansible-files]$ cd /home/rhel/ansible-files/roles
[rhel@control roles]$ cp -rf /usr/share/ansible/roles/rhel-system-roles.selinux/ .
[rhel@control roles]$ cd /home/rhel/ansible
[rhel@control ansible-files]$ vim selinux.yml

---
- name: configure selinux
  hosts: all
  vars:
    selinux_policy: targeted
    selinux_state: enforcing
  roles:
    - rhel-system-roles.selinux

:wq
```

2) Run the "selinux.yml" playbook:
```
[rhel@control ansible-files]$ ansible-navigator run -m stdout selinux.yml
```
output: \
![image](https://github.com/user-attachments/assets/7159724d-26e6-452b-87a1-333c4fc77023)

3) Finally, you may validate the selinux status on all the nodes:
```
[rhel@control ansible-files]$ ansible all -m command -a "getenforce"
<output omitted>
```

* Done!!

[Continue to the Next Lab](19_target_yml_(EASY).md)
