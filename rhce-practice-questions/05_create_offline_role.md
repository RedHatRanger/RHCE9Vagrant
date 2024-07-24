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
[student@control roles]$ ansible-galaxy init apache2
- Role apache2 was created successfully
[student@control roles]$ ls
apache     balancer       phpinfo             rhel-system-roles.selinux
apache2    bbatsche.Ngix  requirements.yml    rhel-system-roles.timesync
[student@control roles]$ cd apache2; ls
[student@control apache2]$ defaults  files   handlers  meta  README.md   tasks  templates  tests  vars
[student@control apache2]$ cd ..
[student@control roles]$ rm -rf apache2
[student@control roles]$ cd apache
[student@control apache]$ cd tasks
```

2) Let's examine the main.yml file:
```
[student@control tasks]$ vim main.yml

---
# tasks file for apache
- name: install httpd and firewalld
  ansible.builtin.dnf:
      name:
        - httpd
        - firewalld
```
