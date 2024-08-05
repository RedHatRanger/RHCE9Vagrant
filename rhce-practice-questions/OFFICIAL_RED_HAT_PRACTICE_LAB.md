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

# vim system_setup.yml:
```
---
- name: Basic System Setup
  hosts: all
  become: true
  vars:
    user_name: 'padawan'
    package_name: httpd
  tasks:
    - name: Install security updates for the kernel
      ansible.builtin.dnf:
        name: 'kernel'
        state: latest
        security: true
        update_only: true
      when: inventory_hostname in groups['web']

    - name: Create a new user
      ansible.builtin.user:
        name: "{{ user_name }}"
        state: present
        create_home: true

    - name: Install Apache on web servers
      ansible.builtin.dnf:
        name: "{{ package_name }}"
        state: present
      when: inventory_hostname in groups['web']
```

# vim system_setup.yml:
```
---
- name: Basic System Setup
  hosts: all
  become: true
  vars:
    user_name: 'padawan'
    package_name: httpd
    apache_service_name: httpd
  tasks:
    - name: Install security updates for the kernel
      ansible.builtin.dnf:
        name: 'kernel'
        state: latest
        security: true
        update_only: true
      when: inventory_hostname in groups['web']

    - name: Create a new user
      ansible.builtin.user:
        name: "{{ user_name }}"
        state: present
        create_home: true

    - name: Install Apache on web servers
      ansible.builtin.dnf:
        name: "{{ package_name }}"
        state: present
      when: inventory_hostname in groups['web']

    - name: Ensure Apache is running and enabled
      ansible.builtin.service:
        name: "{{ apache_service_name }}"
        state: started
        enabled: true
      when: inventory_hostname in groups['web']

    - name: Install firewalld
      ansible.builtin.dnf:
        name: firewalld
        state: present
      when: inventory_hostname in groups['web']

    - name: Ensure firewalld is running
      ansible.builtin.service:
        name: firewalld
        state: started
        enabled: true
      when: inventory_hostname in groups['web']

    - name: Allow HTTP traffic on web servers
      ansible.posix.firewalld:
        service: http
        permanent: true
        state: enabled
      when: inventory_hostname in groups['web']
      notify: Reload Firewall

  handlers:
    - name: Reload Firewall
      ansible.builtin.service:
        name: firewalld
        state: reloaded
```

* Understanding this playbook:
```
The notify section calls the handler only if the "Allow HTTP traffic on web servers" task makes any changes in one of the hosts.
That way the service is only reloaded if needed - and not each time the playbook is run.
The handlers section defines a task that is only run on notification. And the name field is used to call it from a task.
```

# run the updated playbook:
```
ansible-navigator run system_setup.yml
```
