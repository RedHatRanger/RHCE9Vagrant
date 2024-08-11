<a href="https://www.youtube.com/watch?v=0fUMTBiWKhc&list=PLYB6dfdhWDePZf4fd4YgGGtSX_vHKv5vz&index=8">Video Tutorial</a> by Teach Me Tech \
<a href="https://www.youtube.com/watch?v=dMsEJP6szxw&list=PLL_setXLS0tiYMipvQI4oUGkJwhOhn42J&index=17">Video Tutorial</a> by codeXchange (BEST) \
<a href="https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/7/html/automating_system_administration_by_using_rhel_system_roles_in_rhel_7.9/configuring-time-synchronization-by-using-the-timesync-rhel-system-role_automating-system-administration-by-using-rhel-system-roles#applying-the-timesync-system-role-for-a-single-pool-of-servers_configuring-time-synchronization-using-system-roles">Link</a> to the Red Hat Documentation

***On the Control Node***

# Create a timesync.yml playbook
### QUESTION #17:
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

### ANSWER #17:
1) Log into the CONTROL NODE as student, and install the "rhel-system-roles" package if it isn't installed:
```
[student@control ansible]$ sudo yum install rhel-system-roles -y
<output omitted>
[student@control ansible]$ sudo rsync -av --progress /usr/share/ansible/roles/rhel-system-roles.timesync /home/student/ansible/roles
<output omitted>
[student@control roles]$ sudo chown -R student:student rhel-system-roles.timesync/
```

2) Create the "timesync.yml" playbook
```
[student@control ansible]$ ﻿vim timesync.yml

#---
#- name: use timesync
#  hosts: all
#  vars:
#     timesync_ntp_servers:
#         - hostname: classroom.example.com
#           iburst: yes
#  roles:
#     - rhel-system-roles.timesync

# For this example we will use what redhat has provided us:
---
- hosts: all
  vars:
    timesync_ntp_servers:
      - hostname: 2.rhel.pool.ntp.org
        pool: yes
        iburst: yes
  roles:
    - rhel-system-roles.timesync

:wq
```

3) Run the "timesync.yml" playbook:
```
[student@control ansible]$ ﻿ansible-navigator run -m stdout timesync.yml
```

4) Validate the modified settings on the nodes:
```
[student@control ansible]$ ansible all -m shell -a "cat /etc/chrony.conf"

node4 | CHANGED | rc=0 >>
#
# Ansible managed
#
# system_role:timesync


pool 2.rhel.pool.ntp.org iburst

# Allow the system clock to be stepped in the first three updates.
makestep 1.0 3

# Enable kernel synchronization of the real-time clock (RTC).
rtcsync

# Record the rate at which the system clock gains/losses time.
driftfile /var/lib/chrony/drift

# Save NTS keys and cookies.
ntsdumpdir /var/lib/chrony
...node3
...node2
...node1
...node5
```

* Done!!
