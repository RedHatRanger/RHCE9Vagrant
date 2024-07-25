<a href="https://www.youtube.com/watch?v=K2MiUfyy3Lk&list=PLYB6dfdhWDePZf4fd4YgGGtSX_vHKv5vz&index=18">Video Tutorial</a> by Teach Me Tech \
<a href="https://www.youtube.com/watch?v=DDlOBQUt0ug&list=PLL_setXLS0tiYMipvQI4oUGkJwhOhn42J&index=15">Video Tutorial</a> by codeXchange (BEST)

***On the Control Node***

# Create a crontab.yml playbook
### QUESTION #15:
```
Instructions:

15. Create a cronjob for the user student on all nodes, playbook name is crontab.yml and the job details are below:

  i) Every 2 minutes the job will execute logger "EX294 in progress".
```

(scroll down for an answer)
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>

### ANSWER #15:
1) Log into the CONTROL NODE as student, and create the "crontab.yml" playbook
```
[student@control ansible]$ ﻿vim crontab.yml

---
- name: use crontab
  hosts: all
  tasks:
     - name: use cron job
       ansible.builtin.cron:
           name: "test"
           minute: "*/2"
           user: student
           job: logger "EX294 in progress"
           state: present

:wq
```
