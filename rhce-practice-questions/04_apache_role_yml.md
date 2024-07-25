<a href="https://www.youtube.com/watch?v=W2pMZLWK-B4&list=PLYB6dfdhWDePZf4fd4YgGGtSX_vHKv5vz&index=6">Video Tutorial</a> by Teach Me Tech
<a href="https://www.youtube.com/watch?v=jvyfNTuxyjE&list=PLL_setXLS0tiYMipvQI4oUGkJwhOhn42J&index=4">Video Tutorial</a> by codeXchange (BEST)

***On the Control Node***

# Create Offline Role For Apache
### QUESTION #4:
```
Instructions:

5. Create an offline role named "apache" under the roles directory.
i) install the httpd package and the service should be started and enabled.
ii) host the webpage using the template.j2
iii) the template.j2 should contain:
     Welcome to HOSTNAME ON IPADDRESS
     where hostname is the Fully Qualified Domain Name (FQDN)
iv) create the playbook called "apache_role.yml" and run the role on the dev group.
```

(scroll down for an answer)
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>

### ANSWER #4:

1) Log into the CONTROL NODE as student, and run:
```
[student@control ansible]$ pwd
/home/student/ansible
[student@control ansible]$ cd roles
[student@control roles]$ ansible-galaxy init apache
- Role apache was created successfully
```
2) Next, let's create the "template.j2" file for the apache server:
```
[student@control roles]$ cd apache/templates/
[student@control templates]$ vim template.j2

Welcome to {{ ansible_fqdn }} ON {{ ansible_default_ipv4.address }}

:wq
```

3) Let's create the "main.yml" file:
```
[student@control roles]$ cd apache/tasks/
[student@control tasks]$ vim main.yml

---
# tasks file for apache
- name: install httpd and firewalld
  ansible.builtin.dnf:
      name:
        - httpd
        - firewalld
      state: latest

- name: start httpd service
  ansible.builtin.service:
        name: httpd
        state: started
        enabled: yes

- name: start firewalld service
  ansible.builtin.service:
        name: firewalld
        state: restarted
        enabled: yes

- name: add http service in firewall rule
  ansible.posix.firewalld:
        service: http
        state: enabled
        permanent: yes
        immediate: yes

- name: copy the template.j2 file to the webserver directory
  ansible.builtin.template:
        src: template.j2
        dest: /var/www/html/index.html

:wq
```

4) If you don't remember, you can use the ```ansible-doc firewalld``` command, and then SEARCH FOR IT:
```
[student@control tasks]$ ansible-doc firewalld
<output omitted>

:ansible.posix.firewalld
```

5) Now, let's create the "apache_role.yml" file:
```
[student@control templates]$ cd ~/ansible
[student@control ansible]$ vim apache_role.yml

---
- name: use apache role
  hosts: dev
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
