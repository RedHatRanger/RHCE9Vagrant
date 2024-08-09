<a href="https://www.youtube.com/watch?v=Oxd2Zuuv9Cs&list=PLYB6dfdhWDePZf4fd4YgGGtSX_vHKv5vz&index=14">Video Tutorial</a> by Teach Me Tech \
<a href="https://www.youtube.com/watch?v=yGJfoLGaN0E&list=PLL_setXLS0tiYMipvQI4oUGkJwhOhn42J&index=11">Video Tutorial</a> by codeXchange (BEST)

***On the Control Node***

# Create a hosts.yml playbook
### QUESTION #11:
```
Instructions:

11. Download file "http://content.example.com/Rhce/myhosts.j2"

  1) myhosts.j2 is having the content:
   - 127.0.0.1 localhost.localdomain localhost
   - 192.168.0.1 localhost.localdomain localhost

  ii) The file should collect all node information like ipaddress,fqdn,hostname
     and it should be same as /etc/hosts file,
     if playbook is run on all the managed nodes it must store in /etc/myhosts.

Finally /etc/myhosts should like as below:
127.0.0.1 localhost.localdomain localhost
192.168.0.1 localhost.localdomain localhost

172.28.128.100   control.example.com   control
172.28.128.101   node1.example.com     node1
172.28.128.102   node2.example.com     node2
172.28.128.103   node3.example.com     node3
172.28.128.104   node4.example.com     node4
172.28.128.105   node5.example.com     node5

iii) The playbook name should be "hosts.yml" and run it on dev group.
```

(scroll down for an answer)
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>

### ANSWER #11:
MODULES USED:
- template
- file

</br></br>

1) Log into the CONTROL NODE as student, and create the "myhosts.j2" file:
```
[student@control ansible]$ ﻿vim myhosts.j2

127.0.0.1 localhost localhost.localdomain localhost4 localhost4.localdomain4
::1 localhost localhost.localdomain localhost6 localhost.localdomain6

{% for host in groups['all'] %}
{{ hostvars[host].ansible_default_ipv4.address }} {{ hostvars[host].ansible_fqdn }} {{ hostvars[host].ansible_hostname }}
{%endfor%}

:wq
```

2) Next, create the "hosts.yml" playbook:
```

---
- name: Copy from template
  hosts: all
  tasks:
    - name: use template
      ansible.builtin.template:
        src: myhosts.j2
        dest: /etc/myhosts

- name: Remove /etc/myhosts from everything but dev
  hosts: all,!dev
  tasks:
    - name: delete from all
      ansible.builtin.file:
        path: /etc/myhosts
        state: absent

:wq
```

3) Test and run the "hosts.yml" playbook:
```
[student@control ansible]$ ansible-navigator run -m stdout hosts.yml
```

* Finally, you may validate the changes you made:
```
[student@control ansible]$ ansible all -m command -a "cat /etc/myhosts"
```

* Done!!
