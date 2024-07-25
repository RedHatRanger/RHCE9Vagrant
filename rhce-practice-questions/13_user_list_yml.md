<a href="https://www.youtube.com/watch?v=KX8eu8PsTy4&list=PLYB6dfdhWDePZf4fd4YgGGtSX_vHKv5vz&index=16">Video Tutorial</a> by Teach Me Tech \
<a href="https://www.youtube.com/watch?v=HIAX4gQx94U&list=PLL_setXLS0tiYMipvQI4oUGkJwhOhn42J&index=13">Video Tutorial</a> by codeXchange (BEST)

***On the Control Node***

# Create a user_list.yml playbook
### QUESTION #13:
```
Instructions:

﻿13. Download the variable file
"http://content.example.com/Rhce/user_list.yml" and write a playbook named users.yml and then run the playbook
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
1) Log into the CONTROL NODE as student, and run "wget" to download the "user_list.yml" file:
```
[student@control ansible]$ ﻿wget http://content.example.com/Rhce/user_list.yml
```
output: \
![image](https://github.com/user-attachments/assets/01b5fd2b-2feb-4f9a-a274-11118e3cd88e)

2) Edit the "hosts.yml" file:
```

---
- name: user creation
  hosts: dev,test
  vars_files:
     - user_list.yml
     - vault.yml
  tasks:
     - name: add group
       group:
           name: opsdev
           state: present

     - name: adding users
       user:
           name: "{{ item.name }}"
           groups: opsdev
           password: "{{ pw_developer | password_hash('sha512') }}"
       when: item.job=='developer'
       loop: "{{ users }}"

- name: Create users and groups
  hosts: prod
  vars_file:
     - user_list.yml
     - vault.yml
  tasks:
     - name: add group
       group:
           name: opsmgr
           state: present

     - name: adding users
       user:
           name: "{{ item.name }}"
           groups: opsmgr
           password: "{{ pw_manager | password_hash('sha512') }}"
       when: item.job=='manager'
       loop: "{{ users }}"

:wq      
```
