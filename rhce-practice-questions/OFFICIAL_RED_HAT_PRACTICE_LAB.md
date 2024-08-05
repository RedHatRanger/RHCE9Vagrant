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
  hosts: node1

  tasks:
    - name: Install security updates for the kernel
      ansible.builtin.dnf:
        name: "kernel"
        state: latest
        security: true

    - name: Create a new user
      ansible.builtin.user:
        name: myuser
        state: present
        create_home: true
```
