```
# vim /home/student/ansible/playbooks/byrole.yml

---
- name: Full install
  hosts: all
  roles:
  - fullinstall

- name: Basic install
  hosts: localhosts
  roles:
  - basicinstall
```

![image](https://github.com/user-attachments/assets/505df7e3-8255-4e2a-8c2b-948d5bed53fe)
