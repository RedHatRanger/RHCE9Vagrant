<a href="https://www.youtube.com/watch?v=jOUqUUuca0w&list=PLYB6dfdhWDePZf4fd4YgGGtSX_vHKv5vz&index=5">Video Tutorial</a> by Teach Me Tech \
<a href="https://www.youtube.com/watch?v=nqxoLgIMHhY&list=PLL_setXLS0tiYMipvQI4oUGkJwhOhn42J&index=3">Video Tutorial</a> by codeXchange

***On the Control Node***

# Install the Roles
### QUESTION #3:
```
Instructions:

4. Install the roles
i) create directory "roles" under /home/student/ansible
ii) create a "requirements.yml" under the roles directory and download the given roles under it using the galaxy command.
iii) 1st role name should be "balancer" and download it using this url "http://content.example.com/rhce/balancer.tgz".
iv)  2nd role name will be "phpinfo" and download it using this url "http://content.example.com/rhce/phpinfo.tgz".

For this example we will use (This part will not be on the exam, but for real exam you will use WGET for the content files):
https://github.com/bbatsche/Ansible-PHP-Site-Role.git            (phpinfo)
https://github.com/geerlingguy/ansible-role-haproxy.git            (balancer)

* Note: You can find them on galaxy.ansible.com and search for the roles "geerlingguy.haproxy" and "bagaswh.php".
        Then you can open their github pages and copy the https link.
```

(scroll down for an answer)
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>

### ANSWER #3:

1) Log into the CONTROL NODE as student, and run:
```
# NOTE: On the actual exam you may have to wget from an http://content/.../.../ repository and install them locally
 
[student@control ansible]$ mkdir roles  # If did not create it in Lab #1
[student@control ansible]$ cd roles
[student@control roles]$ vim requirements.yml

---
- src: https://github.com/bbatsche/Ansible-PHP-Site-Role.git
  name: phpinfo

- src: https://github.com/geerlingguy/ansible-role-haproxy.git
  name: balancer

:wq
```

2) Next, run the requirements.yml file using ansible-galaxy:
```
[student@control roles]$ ansible-galaxy install -r /home/student/ansible/roles/requirements.yml -p /home/student/ansible/roles
<output omitted>
```

3) Finally, you can confirm that the roles have been installed by running "ls":
```
[student@control roles]$ ls
apache     bbatsche.Nginx  requirements.yml   rhel-system-roles.timesync
balancer   phpinfo         rhel-system-roles.selinux
```

* Done!!
