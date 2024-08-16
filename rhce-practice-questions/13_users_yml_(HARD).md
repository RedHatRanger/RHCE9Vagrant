<a href="https://www.youtube.com/watch?v=KX8eu8PsTy4&list=PLYB6dfdhWDePZf4fd4YgGGtSX_vHKv5vz&index=16">Video Tutorial</a> by Teach Me Tech \
<a href="https://www.youtube.com/watch?v=HIAX4gQx94U&list=PLL_setXLS0tiYMipvQI4oUGkJwhOhn42J&index=13">Video Tutorial</a> by codeXchange (BEST)
</br></br>

### NOTE: If you ran out of time on the RED HAT OFFICIAL LAB, [Click Here](#Catch-Up) 

***On the Control Node***

# Create a users.yml playbook
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
