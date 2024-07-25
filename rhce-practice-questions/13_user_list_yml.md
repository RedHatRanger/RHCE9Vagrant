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
1) Log into the CONTROL NODE as student, and create the "myhosts.j2" file:
```
[student@control ansible]$ ﻿vim myhosts.j2
