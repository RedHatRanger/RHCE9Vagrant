<a href="https://www.youtube.com/watch?v=7fb98SMGOcw&list=PLYB6dfdhWDePZf4fd4YgGGtSX_vHKv5vz&index=9">Video Tutorial</a> by Teach Me Tech \
<a href="https://www.youtube.com/watch?v=2u1eNdrGhjE&list=PLL_setXLS0tiYMipvQI4oUGkJwhOhn42J&index=18">Video Tutorial</a> by codeXchange (BEST)

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
1) Log into the CONTROL NODE as student, and create the "selinux.yml" file:
```
[student@control roles]$ sudo rsync -av --progress /usr/share/ansible/roles/rhel-system-roles.selinux /home/student/ansible/roles
[student@control roles]$ cd /home/student/ansible
[student@control ansible]$ vim selinux.yml

---
- name: configure selinux
  hosts: all
  vars:
      selinux_state: enforcing
  roles:
    - role: rhel-system-roles.selinux
      become: true

:wq
```

2) Run the "selinux.yml" playbook:
```
[student@control ansible]$ ansible-navigator run -m stdout selinux.yml
```
output: \
![image](https://github.com/user-attachments/assets/7159724d-26e6-452b-87a1-333c4fc77023)

3) Finally, you may validate the selinux status on all the nodes:
```
[student@control ansible]$ ansible all -m command -a "getenforce"
<output omitted>
```

* Done!!
