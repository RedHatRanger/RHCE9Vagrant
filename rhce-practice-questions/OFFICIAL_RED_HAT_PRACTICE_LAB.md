<a href="https://developers.redhat.com/learning/learn:ansible:yaml-essentials-ansible/resource/resources:hands-interactive-lab-and-helpful-resources">Hands-on interactive lab by Red Hat</a>

# vim inventory:
```
[web]
node1
node2
```

# vim ansible.cfg:
```
[defaults]
remote_user=rhel
inventory=./inventory
ask_pass=false
host_key_checking=false

[privilege_escalation]
become=true
become_user=root
become_method=sudo
become_ask_pass=false
```

# vim system_setup.yml:
```
---
- name: Basic System Setup
  hosts: web
  become: true
  tasks:
    - name: Install security updates for the kernel
      ansible.builtin.dnf:
        name: 'kernel'
        state: latest
        security: true

    - name: Create a new user
      ansible.builtin.user:
        name: myuser
        state: present
        create_home: true
```

# run the playbook:
```
$ ansible-navigator run -m stdout system_setup.yml
```

# Check to see if the "myuser" user has been created:
```
[rhel@control ansible-files]$ ssh node1 id myuser
```

# vim system_setup.yml: 
```
---
- name: Basic System Setup
  hosts: web
  become: true
  vars:
    user_name: 'padawan'
  tasks:
    - name: Install security updates for the kernel
      ansible.builtin.dnf:
        name: 'kernel'
        state: latest
        security: true

    - name: Create a new user
      ansible.builtin.user:
        name: "{{ user_name }}"
        state: present
        create_home: true
```

# vim inventory:
```
[web]
node1
node2

[database]
node3
```
