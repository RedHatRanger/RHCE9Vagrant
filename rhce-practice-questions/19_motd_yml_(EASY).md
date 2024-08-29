# BONUS LAB

1) Create a file called motd.j2 in the templates folder:
```
[rhel@control ansible-files]$ mkdir ~/ansible-files/templates  #If you haven't created it yet.
[rhel@control ansible-files]$ vim /home/rhel/ansible-files/templates/motd.j2

Welcome to {{ ansible_hostname }}.
OS: {{ ansible_distribution }} {{ ansible_distribution_version }}
Architecture: {{ ansible_architecture }}

:wq
```

2) Create an "motd.yml" file to include the motd Jinja template:
```
---
- name: Create a greeting for each node
  hosts: all
  tasks:
    - name: setup the greeting from jinja template
      ansible.builtin.template:
        src: templates/motd.j2
        dest: /etc/motd
```

3) Run the playbook:
```
[rhel@control ansible-files]$ ansible-navigator run -m stdout motd.yml
```

4) Test the greeting on node1:
```
[rhel@control ansible-files]$ ssh node1
Welcome to node1.
OS: RedHat 9.4
Architecture: x86_64
```

* Done!!
