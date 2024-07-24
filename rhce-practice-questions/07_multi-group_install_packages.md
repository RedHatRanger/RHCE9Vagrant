<a href="https://www.youtube.com/watch?v=UkAhDPc--eI&list=PLL_setXLS0tiYMipvQI4oUGkJwhOhn42J&index=7">Video Tutorial</a> by codeXchange

***On the Control Node***

# Install Packages in Muliple Groups
### QUESTION #7:
```
Instructions:

7. Install packages in multiple groups
i) Install vsftpd and mariadb-server packages in dev and test group.
ii) Install "RPM Development Tools" group package in prod group.
iii) Update all packages in dev group.
iv) Use separate play for each task and playbook name should be packages.yml.
```

(scroll down for an answer)
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>

### ANSWER #7:

1) Log into the CONTROL NODE as student, and run:
```
[student@control ansible]$ vim packages.yml

---
- name: packages installation
  hosts: dev,test
  tasks:
     - name: installing vsftpd and mariadb-server packages
       ansible.builtin.dnf:
           name:
              - vsftpd
              - mariadb-server
           state: present

- name: group package installation
  hosts: prod
  tasks:
     - name: Installing "RPM Development Tools" group package
       ansible.builtin.dnf:
           name: "@RPM Development Tools"
           state: present

- name: update all packages
  hosts: dev
  tasks:
     - name: updating all packages
       ansible.builtin.dnf:
           name: "*"
           state: latest

:wq
```

2) Test and Run the packages.yml playbook:
```
[student@control ansible]$ ansible-navigator run -m stdout packages.yml -C
<output omitted>
[student@control ansible]$ ansible-navigator run -m stdout packages.yml
![image](https://github.com/user-attachments/assets/afb234ed-1729-42ec-ae86-0452be2af6d5)

```
