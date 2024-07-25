<a href="https://www.youtube.com/watch?v=0fUMTBiWKhc&list=PLYB6dfdhWDePZf4fd4YgGGtSX_vHKv5vz&index=8">Video Tutorial</a> by Teach Me Tech \
<a href="https://www.youtube.com/watch?v=dMsEJP6szxw&list=PLL_setXLS0tiYMipvQI4oUGkJwhOhn42J&index=17">Video Tutorial</a> by codeXchange (BEST)

***On the Control Node***

# Create an timesync.yml playbook
### QUESTION #16:
```
Instructions:

﻿17. Use a RHEL timesync system role:

 i) Create a playbook called "timesync.yml" that:
 - Runs on all managed nodes
 - Uses the timesync role
 - Configures the role to use the currently active NTP provider
 - Configure the role to use the time server classroom.lab.example.com
 - Configure the role to enable the iburst parameter
```

(scroll down for an answer)
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>

### ANSWER #16:
1) Log into the CONTROL NODE as student, and install the "rhel-system-roles" package if it isn't installed:
```
[student@control ansible]$ sudo yum install rhel-system-roles -y
<output omitted>
```

2) Create the "timesync.yml" playbook
```
[student@control ansible]$ ﻿vim timesync.yml

---
- name: use timesync
  hosts: all
  vars:
     timesync_ntp_servers:
         - hostname: classroom.example.com
           iburst: yes
  roles:
     - rhel-system-roles.timesync

:wq
```

3) Run the "timesync.yml" playbook:
```
[student@control ansible]$ ﻿ansible-navigator run -m stdout timesync.yml
```
output: \
![image](https://github.com/user-attachments/assets/0e095f8c-d8eb-4fcc-b254-577f56b4cc0e)

* Done!!
