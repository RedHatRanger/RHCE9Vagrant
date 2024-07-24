<a href="https://www.youtube.com/watch?v=W2pMZLWK-B4&list=PLYB6dfdhWDePZf4fd4YgGGtSX_vHKv5vz&index=6">Video Tutorial</a> by Teach Me Tech

***On the Control Node***

# Create Offline Role For Apache
### QUESTION #5:
```
Instructions:

5. Create an offline role named "apache" under the roles directory.
i) install the httpd package and the service should be started and enabled.
ii) host the webpage using the template.j2
iii) the template.j2 should contain:
     my host is HOSTNAME on IPADDRESS
     where hostname is the Fully Qualified Domain Name (FQDN)
iv) create the playbook called apache_role.yml and run the role on the dev group.
```

(scroll down for an answer)
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>

### ANSWER #5:

1) Log into the CONTROL NODE as student, and run:
```
[student@control ansible]$ pwd
/home/student/ansible
[student@control ansible]$ cd roles
[student@control roles]$ ansible-galaxy init apache
- Role apache2 was created successfully
```

2) Let's examine the main.yml file, as this is how it SHOULD LOOK:
```
[student@control roles]$ cd ./apache/tasks
[student@control tasks]$ vim main.yml

---
# tasks file for apache
- name: install httpd and firewalld
  ansible.builtin.dnf:
      name:
        - httpd
        - firewalld
      state: latest

- name: start and enable firewalld
  ansible.builtin.service:
        name: firewalld
        state: started
        enabled: true
- name: host the web page using the template
  ansible.builtin.template:
        src: template.j2
        dest: /var/www/html/index.html
- name: allow the http traffic from the firewall
  ansible.posix.firewalld:
        service: http
        permanent: true
        state: enabled
        immediate: true
- name: start and enable httpd service
  ansible.builtin.service:
        name: httpd
        state: started
        enabled: true

:wq
```

3) If you don't remember, you can use the ```ansible-doc firewalld``` command, and then SEARCH FOR IT:
```
[student@control tasks]$ ansible-doc firewalld
<output omitted>

:ansible.posix.firewalld
```

4) Next, let's create the "template.j2" file for the apache server:
```
[student@control tasks]$ cd ../templates
[student@control templates]$ vim template.j2

My host is {{ ansible_fqdn }} {{ ansible_default_ipv4.address }}

:wq
```

5) Now, let's create the "apache_role.yml" file:
```
[student@control templates]$ cd ../../../
[student@control ansible]$ vim apache_role.yml

- hosts: dev
  roles:
      - apache

:wq
```

6) Finally, run the playbook using Ansible Navigator with syntax check TO CHECK FOR ERRORS and DRY RUN IT:
```
[student@control ansible]$ ansible-navigator run -m stdout apache_role.yml --syntax-check
playbook: /home/student/ansible/apache_role.yml
[student@control ansible]$ ansible-navigator run -m stdout apache_role.yml -C

PLAY [dev] ******************************************************************

TASK [Gathering Facts] ******************************************************
ok: [node1]

TASK [apache : install httpd and firewalld] *********************************
changed: [node1]

TASK [apache : start and enable firewalld] **********************************
ok: [node1]

TASK [apache : host the webpage using the template] *************************
changed: [node1]

TASK [apache : allow the http traffic from the firewall] ********************
changed: [node1]

TASK [apache : start and enable httpd] **************************************
changed: [node1]

PLAY RECAP ******************************************************************
node1                          : ok=6     changed=4     unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
[student@control ansible]$
```

7) Let's test out using curl on the webpage:
```
[student@control ansible]$ curl http://node1.example.com
My host is node1.example.com 172.28.128.101
[student@control ansible]$ 
```

* Done!!

### Some possible errors you may encounter: ###
  Because you are not registered with Red Hat, you may have to mount the DVD each time you reboot, unless you fix it in /etc/fstab to be permanent.
