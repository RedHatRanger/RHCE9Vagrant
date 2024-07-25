<a href="https://www.youtube.com/watch?v=1_hTAanKxOU&list=PLYB6dfdhWDePZf4fd4YgGGtSX_vHKv5vz&index=13">Video Tutorial</a> by Teach Me Tech \
<a href="https://www.youtube.com/watch?v=lVdJ3ViMrnw&list=PLL_setXLS0tiYMipvQI4oUGkJwhOhn42J&index=10">Video Tutorial</a> by codeXchange (BEST)

***On the Control Node***

# Create a hwreport.yml playbook
### QUESTION #10:
```
Instructions:

10. Replace file /etc/issue on all managed nodes

i)   In dev group /etc/issue should have content "Development"
ii)  In test group /etc/issue should have content "Test"
iii) In prod group /etc/issue should have content "Production"
iv)  Playbook name issue.yml and run on all managed nodes
```

(scroll down for an answer)
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>

### ANSWER #10:
1) Log into the CONTROL NODE as student, and create the "hwreport.empty" file in the ~/ansible directory:
```
[student@control ansible]$ vim issue.yml

---
- name: content in dev
  hosts: dev
  tasks:
    - name: copy using inline content
      ansible.builtin.copy:
          content: "Development"
          dest: /etc/issue

- name: content in prod hosts prod
  hosts: prod
  tasks:
    - name: copy using inline content
      ansible.builtin.copy:
          content: "Production"
          dest: /etc/issue

- name: content in dev
  hosts: test
  tasks:
    - name: copy using inline content
      ansible.builtin.copy:
          content: "Test"
          dest: /etc/issue
﻿
:wq
```
