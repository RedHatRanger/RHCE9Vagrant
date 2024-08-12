<a href="https://www.youtube.com/watch?v=yn_feC84g4Y&list=PLYB6dfdhWDePZf4fd4YgGGtSX_vHKv5vz&index=4">Video Tutorial</a> by Teach Me Tech \
<a href="https://www.youtube.com/watch?v=FgBzX0qiQi4&list=PLL_setXLS0tiYMipvQI4oUGkJwhOhn42J&index=5">Video Tutorial</a> by codeXchange \
<a href="https://docs.ansible.com/ansible/latest/collections_guide/collections_installing.html#installing-collections-with-ansible-galaxy">Link</a> to the Ansible Documentation

***On the Control Node***

# Install Collections
### QUESTION #6:
```
Instructions:

6. Install Ansible Content Collections:

i) create a directory "mycollections" under /home/student/ansible/
ii) using the url "https://galaxy.ansible.com/download/ansible-posix-1.5.4.tar.gz" to install ansible.posix collection under the mycollections directory.
iii) using the url "https://galaxy.ansible.com/download/community-general-9.2.0.tar.gz" to install the community-general collection under the mycollections directory.
----------------------------------------------------------------------------


NOTE ON THE EXAM:
Example url: http://content.example.com/rhce/ansible-posix....
```

(scroll down for an answer)
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>

### ANSWER #6:
You will have to install:
- ansible.posix
- redhat-insights
- community.general
- rhel-system-roles

</br></br>
1) Log into the CONTROL NODE as student; download and install the collections:
```
[student@control ansible]$ ansible-galaxy collection install https://galaxy.ansible.com/download/ansible-posix-1.5.4.tar.gz -p mycollections/
<output omitted>
[student@control ansible]$ ansible-galaxy collection install https://galaxy.ansible.com/download/community-general-9.2.0.tar.gz -p mycollections/
<output omitted>
```

2) Run the ansible-navigator check to see if the collections are available:
```
[student@control ansible]$ ansible-navigator collections
Name                 Version         Shadowed        Type         Path
0|ansible.builtin    2.15.0          False           contained    /usr/local/bin/python3.11/site-packages/ansible
1|ansible.posix      1.5.1           False           bind_mount   /home/student/ansible/mycollections/ansible_collect...
2|community.general  5.4.0           False           bind_mount   /home/student/ansible/mycollections/ansible_collect...
```

3) Now, because you installed the ansible.posix collection, you are able to lookup ansible documentation on firewalld:
```
[student@control ansible]$ ansible-doc firewalld
<output omitted>
```

* Done!!