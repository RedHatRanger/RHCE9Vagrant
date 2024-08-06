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


![Screenshot 2024-08-06 084724](https://github.com/user-attachments/assets/99b50002-6b14-401d-b967-feee0f9357d4)
