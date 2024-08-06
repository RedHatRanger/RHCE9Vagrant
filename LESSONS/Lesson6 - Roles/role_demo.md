# vim role.yml
```
---
- name: role demo
  hosts: all
  become: true
  roles: 
    - role: lucab85.ansible_role_log4shell
      detector_path: "/var/www"
```

# vim requirements.yml
```
---
roles:
  - name: lucab85.ansible_role_log4shell
```
