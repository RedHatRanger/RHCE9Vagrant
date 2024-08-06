```
---
- name: Install packages
  hosts: all
  tasks:
  - name: Install Apache package
    yum:
     name: httpd
     state: present

  - name: Install Time package
    yum:
     name: ntpd or chrony
     state: present

  - name: Install DNS package
     yum:
     name: named
     state: present
```

![image](https://github.com/user-attachments/assets/b1e9dfa9-4f06-4687-ac7d-03b588b267bb)
