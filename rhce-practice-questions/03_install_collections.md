<a href="https://www.youtube.com/watch?v=yn_feC84g4Y&list=PLYB6dfdhWDePZf4fd4YgGGtSX_vHKv5vz&index=4">Video Tutorial</a> by Teach Me Tech

***On the Control Node***

# Install Collections
### QUESTION #3:
```
Instructions:

3. Install the collections:

i) create a directory "collections" under /home/student/ansible/
ii) using the url "http://content/Rhce/ansible-posix-1.4.0.tar.gz" to install ansible.posix collection under the collections directory.
iii) using the url "http://content/Rhce/redhat-rhel_system_roles-1.0.0.tar.gz" to install roles collection under the collections directory.
----------------------------------------------------------------------------

https://galaxy.ansible.com/download/ansible-posix-1.5.4.tar.gz

https://galaxy.ansible.com/download/community-general-5.4.0.tar.gz

ON THE EXAM:
Example url: ....................../ansible-posix

You will have to install:
- ansible.posix
- community-general
- rhel-system-roles
```

(scroll down for an answer)
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>

### ANSWER #3:

1) Log into the CONTROL NODE as student; download and install the collections:
```
ansible-galaxy collection install https://galaxy.ansible.com/download/ansible-posix-1.5.4.tar.gz -p mycollections/
```
