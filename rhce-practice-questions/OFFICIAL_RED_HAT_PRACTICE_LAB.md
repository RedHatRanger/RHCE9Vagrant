<a href="https://developers.redhat.com/learning/learn:ansible:yaml-essentials-ansible/resource/resources:hands-interactive-lab-and-helpful-resources">Hands-on interactive lab by Red Hat</a>


# echo "cd ~/ansible-files" >> ~/.bashrc; . ~/.bashrc

# vim inventory:
```
[web]
node1
node2

[database]
node3
```

# vim ansible.cfg:
```
[defaults]
remote_user=rhel
inventory=/home/rhel/ansible-files/inventory
roles_path=/home/rhel/ansible-files/roles
collections_path=/home/rhel/ansible-files/mycollections
ask_pass=false
host_key_checking=false

[privilege_escalation]
become=true
become_medthod=sudo
become_user=root
become_ask_pass=false
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

# run the playbook:
```
$ ansible-navigator run -m stdout system_setup.yml
```

# Check to see if the "myuser" user has been created:
```
[rhel@control ansible-files]$ ssh node1 id myuser
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

# check that http is working on node1:
```
curl http://node1 | grep "HTTP Server"
```

# create a new playbook called "loop_users.yml":
```
---
- name: Create multiple users with a loop
  hosts: node1
  become: true

  tasks:
    - name: Create a new user
      ansible.builtin.user:
        name: "{{ item }}"
        state: present
        create_home: true
      loop:
        - alice
        - bob
        - carol
```

# run the playbook "loop_users.yml":
```
ansible-navigator run loop_users.yml
```

# Understand the playbook and the output:
```
The names are not provided to the ansible.builtin.user module directly.
Instead, there is only a variable called {{ item }} for the parameter name.
The loop keyword lists the actual user names. Those replace the {{ item }} during the actual execution of the playbook.
During execution the task is only listed once, but there are three changes listed underneath it.
```

# check if the user Alice has been created on node1:
```
ansible node1 -m shell -a "id alice"
```

# create a new folder in ansible-files called "templates", and then create a file called motd.j2:
```
$ vim motd.j2

Welcome to {{ ansible_hostname }}.
OS: {{ ansible_distribution }} {{ ansible_distribution_version }}
Architecture: {{ ansible_architecture }}
```

# update the "system_setup.yml" file to include the new Jinja template:
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

    - name: Update MOTD from Jinja2 Template
      ansible.builtin.template:
        src: templates/motd.j2
        dest: /etc/motd

  handlers:
    - name: Reload Firewall
      ansible.builtin.service:
        name: firewalld
        state: reloaded

```

# test out the message of the day:
```
[rhel@control ansible-files]$ ssh node1
```

# create a "roles" directory, and build an apache role:
```
[rhel@control ansible-files]$ mkdir roles
[rhel@control ansible-files]$ ansible-galaxy init --offline roles/apache
```

# view the roles directory:
```
[rhel@control ansible-files]$ tree roles
```

