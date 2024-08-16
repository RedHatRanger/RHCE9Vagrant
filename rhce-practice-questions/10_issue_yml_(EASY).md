<a href="https://www.youtube.com/watch?v=1_hTAanKxOU&list=PLYB6dfdhWDePZf4fd4YgGGtSX_vHKv5vz&index=13">Video Tutorial</a> by Teach Me Tech \
<a href="https://www.youtube.com/watch?v=lVdJ3ViMrnw&list=PLL_setXLS0tiYMipvQI4oUGkJwhOhn42J&index=10">Video Tutorial</a> by codeXchange (BEST) \
<a href="https://docs.ansible.com/ansible/latest/collections/ansible/builtin/copy_module.html#ansible-builtin-copy-module-copy-files-to-remote-locations">Link</a> to the Ansible Documentation

***On the Control Node***

# Create an issue.yml playbook
### QUESTION #10:
```
Instructions:

10. Replace file /etc/issue on all managed nodes

i)   In dev group /etc/issue should have content "Development"
ii)  In test group /etc/issue should have content "Test"
iii) In prod group /etc/issue should have content "Production"
iv)  Playbook name should be issue.yml and run on all managed nodes
```

(scroll down for an answer)
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>

### ANSWER #10:
MODULES USED:
- copy
- You can run "ansible-doc copy" to get the parameters for the yml file

</br></br>
1) Log into the CONTROL NODE as student, and create the "issue.yml" playbook:
```
[student@control ansible]$ vim issue.yml

---
- name: Configure /etc/issue content based on environment
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

2) Test and run the playbook:
```
[student@control ansible]$ ansible-navigator run -m stdout issue.yml
```

3) Validate the /etc/issue file on all nodes:
```
[student@control ansible]$ ansible dev,test,prod -m command -a "cat /etc/issue; echo -e '\n '"
nodel | CHANGED | rc=0 >>
Development

node2 | CHANGED | rc=0 >>
Test

node3 | CHANGED | rc=0 >>
Production

node4 | CHANGED | rc=0 >>
Production
```

* Done!!

</br></br>
[Continue to next lab](11_hosts_yml_(MEDIUM).md)
