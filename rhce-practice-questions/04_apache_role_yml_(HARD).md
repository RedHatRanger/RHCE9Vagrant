<a href="https://www.youtube.com/watch?v=W2pMZLWK-B4&list=PLYB6dfdhWDePZf4fd4YgGGtSX_vHKv5vz&index=6">Video Tutorial</a> by Teach Me Tech \
<a href="https://www.youtube.com/watch?v=KjJ4lCvMPMA&list=PLtt9NBONpp0MJlYGrigUukueTlp1d-rc8&index=16">Video Tutorial</a> by T_For_Tech \
<a href="https://www.youtube.com/watch?v=jvyfNTuxyjE&list=PLL_setXLS0tiYMipvQI4oUGkJwhOhn42J&index=4">Video Tutorial</a> by codeXchange (BEST) \
<a href="https://www.youtube.com/watch?v=tq9sCeQNVYc&list=PLT98CRl2KxKEUHie1m24-wkyHpEsa4Y70&index=14">Video Tutorial Link1</a> by Learn Linux TV \
<a href="https://www.youtube.com/watch?v=s8F_YWGHeDM&list=PLT98CRl2KxKEUHie1m24-wkyHpEsa4Y70&index=16">Video Tutorial Link2</a> by Learn Linux TV \
<a href="https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_templating.html#templating-jinja2">Link1</a> <a href="https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_reuse_roles.html#using-roles-at-the-play-level">Link2</a> to the Ansible Documentation


* You will need to install the ansible.posix and community.general to get this lab to work [HERE](06_install_collections_(EASY).md) \

  
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
iv) create the playbook called "apache_role.yml" and run the role on the webservers group.
```

(scroll down for an answer)
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>

### ANSWER #4:

1) Log into the CONTROL NODE as rhel, and run:
```
[rhel@control ansible-files]]$ cd /home/rhel/ansible-files/roles
[rhel@control roles]$ ansible-galaxy role init --offline apache
- Role apache was created successfully
```
2) Next, let's create the "template.j2" file for the apache server:
```
[rhel@control roles]$ cd apache/templates/
[rhel@control templates]$ vim template.j2
# ON THE TEST IT MAY BE "ansible_default_ipv4.address"

Welcome to {{ ansible_fqdn }} ON {{ ansible_eth1.ipv4.address }}

:wq
```

3) Let's create the "main.yml" file:
```
[rhel@control templates]$ cd ../tasks
[rhel@control tasks]$ vim main.yml
```
```yaml
---
# tasks file for apache
- name: install httpd and firewalld
  ansible.builtin.dnf:
    name:
      - httpd
      - firewalld
    state: latest

- name: start both services
  ansible.builtin.service:
    name: "{{ item }}"
    state: restarted
    enabled: yes
  loop:
    - httpd
    - firewalld

- name: add http service to the firewall rule
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
[rhel@control tasks]$ ansible-doc firewalld
```

5) Now, let's create the "apache_role.yml" file:
```
[rhel@control templates]$ cd ~/ansible-files
[rhel@control ansible-files]]$ vim apache_role.yml

---
- hosts: webservers
  roles:
    - apache

:wq
```

6) Finally, run the playbook using Ansible Navigator:
```
[rhel@control ansible-files]]$ ansible-navigator run -m stdout apache_role.yml

# YOU MAY NEED TO delete THE myrepo.repo IF IT GIVES YOU ERRORS ON THE RED HAT OFFICIAL LAB:
# ansible all -m shell -a "rm -f /etc/yum.repos.d/myrepo.repo; yum clean all"
```

7) Let's test out using curl on the webpage:
```
[rhel@control ansible-files]]$ curl http://node3
My host is node3.example.com 172.28.128.103
```

* Done!!

[Continue to the Next Lab](05_create_and_run_roles_yml_(EASY).md)

### Some possible errors you may encounter: ###
- ON VMs:
     Because you are not registered with Red Hat, you have to mount the DVD in /etc/fstab to be permanent.
  
- ON RED HAT OFFICIAL LAB:
     You will have to delete the "myrepo.repo" file you created earlier by running the adhoc command provided above.
