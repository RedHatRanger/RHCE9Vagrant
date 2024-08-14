



1) Create a file called motd.j2 in the templates folder:
```
cat << EOF > /home/rhel/ansible-files/templates/motd.j2
Welcome to {{ ansible_hostname }}.
OS: {{ ansible_distribution }} {{ ansible_distribution_version }}
Architecture: {{ ansible_architecture }}
EOF
```

2) Create your 1st "system_setup.yml" file to include the motd Jinja template:
```
cat << EOF > system_setup.yml
---
- name: Basic System Setup
  hosts: all
  become: true
  vars:
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

    - name: Create some new users and give them home folders
      ansible.builtin.user:
        name: "{{ item }}"
        state: present
        create_home: true
      loop:
        - alice
        - bob
        - carol

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
EOF
```

3) Run the playbook:
```
ansible-navigator run -m stdout system_setup.yml
```

4) Check if the user Alice has been created on node1:
```
ssh node1 id alice
```

5) Check that http is working on node1:
```
curl http://node1 | grep "HTTP Server"
```

6) Test out the message of the day:
```
ssh node1
```

7) Exit node1
```
exit
```

8) Build a templated role called "apache"
```
ansible-galaxy init --offline roles/apache
```

* NOTES:
```
The notify section calls the handler only if the "Allow HTTP traffic on web servers" task makes any changes in
one of the hosts.  That way the service is only reloaded if needed - and not each time the playbook is run.
The handlers section defines a task that is only run on notification. And the name field is used to call it from a task.
```