<a href="https://www.youtube.com/watch?v=jOUqUUuca0w&list=PLYB6dfdhWDePZf4fd4YgGGtSX_vHKv5vz&index=5">Video Tutorial</a> by Teach Me Tech (BEST) \
<a href="https://www.youtube.com/watch?v=50gQQyLD7n4&list=PLtt9NBONpp0MJlYGrigUukueTlp1d-rc8&index=18">Video Tutorial</a> by T_For_Tech \
<a href="https://www.youtube.com/watch?v=nqxoLgIMHhY&list=PLL_setXLS0tiYMipvQI4oUGkJwhOhn42J&index=3">Video Tutorial</a> by codeXchange \
<a href="https://docs.ansible.com/ansible/latest/galaxy/user_guide.html#installing-multiple-roles-from-a-file">Link</a> to the Ansible Documentation

***On the Control Node***

# Install the Roles
### QUESTION #4:
```
Instructions:

4. Install the roles
i) create directory "roles" under /home/rhel/ansible-files
ii) create a "requirements.yml" under the roles directory and download the given roles under it using the galaxy command.
iii) 1st role name should be "balancer" and download it using this url "http://content.example.com/rhce/balancer.tgz".
iv)  2nd role name will be "phpinfo" and download it using this url "http://content.example.com/rhce/phpinfo.tgz".

For this example we will use (This part will not be on the exam, but for real exam you will use WGET for the content files):
https://github.com/RedHatRanger/phpinfo.git                        (phpinfo)
https://github.com/RedHatRanger/balancer.git                       (balancer)

* Note: You can find them on galaxy.ansible.com and search for the roles "geerlingguy.haproxy" and "bagaswh.php".
        Then you can open their github pages and copy the https link.
```

(scroll down for an answer)
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>

### ANSWER #4:

1) Log into the CONTROL NODE as rhel, and run:
```
# NOTE: On the actual exam you may have to wget from an http://content/.../.../ repository and install them locally
 
[rhel@control ansible]$ mkdir roles  # If did not create it in Lab #1
[rhel@control ansible]$ cd roles
[rhel@control roles]$ vim requirements.yml
```
```yaml
---
- src: https://github.com/RedHatRanger/phpinfo.git
  name: phpinfo

- src: https://github.com/RedHatRanger/balancer.git
  name: balancer
```

2) Next, run the requirements.yml file using ansible-galaxy:
```
[rhel@control roles]$ ansible-galaxy role install -r requirements.yml -p /home/rhel/ansible-files/roles
```

3) Finally, you can confirm that the roles have been installed by running "ls":
```
[rhel@control roles]$ ls
balancer   phpinfo     requirements.yml
```

* Done!!

[Continue to the Next Lab](05_apache_role_yml_(HARD).md)
