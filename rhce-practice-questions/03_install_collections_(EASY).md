<a href="https://www.youtube.com/watch?v=yn_feC84g4Y&list=PLYB6dfdhWDePZf4fd4YgGGtSX_vHKv5vz&index=4">Video Tutorial</a> by Teach Me Tech \
<a href="https://www.youtube.com/watch?v=mHFtAXCi5kw&list=PLtt9NBONpp0MJlYGrigUukueTlp1d-rc8&index=17">Video Tutorial</a> by T_For_Tech \
<a href="https://www.youtube.com/watch?v=FgBzX0qiQi4&list=PLL_setXLS0tiYMipvQI4oUGkJwhOhn42J&index=5">Video Tutorial</a> by codeXchange \
<a href="https://docs.ansible.com/ansible/latest/collections_guide/collections_installing.html#installing-collections-with-ansible-galaxy">Link</a> to the Ansible Documentation

***On the Control Node***

### QUESTION #3:
```
Instructions:

3. Install Ansible Content Collections:

i) create a directory "mycollections" under /home/rhel/ansible-files/
ii) using the url "https://galaxy.ansible.com/download/ansible-posix-1.6.2.tar.gz" to install ansible.posix collection under the mycollections directory.
iii) using the url "https://galaxy.ansible.com/download/community-general-10.0.1.tar.gz" to install the community-general collection under the mycollections directory.
----------------------------------------------------------------------------


NOTE ON THE EXAM:
Example url: http://content.example.com/rhce/ansible-posix....
```

(scroll down for an answer)
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>

### ANSWER #3:
You will have to install:
- ansible.posix
- redhat-insights
- community.general
- rhel-system-roles

</br></br>
1) Log into the CONTROL NODE as rhel; download and install the collections:
```
ansible-galaxy collection install https://galaxy.ansible.com/download/ansible-posix-1.6.2.tar.gz -p mycollections/
ansible-galaxy collection install https://galaxy.ansible.com/download/community-general-10.0.1.tar.gz -p mycollections/
```

2) Run the ansible-navigator check to see if the collections are available:
```
[rhel@control ansible]$ ansible-navigator collections
Name                 Version         Shadowed        Type         Path
0|ansible.builtin    2.15.0          False           contained    /usr/local/bin/python3.11/site-packages/ansible
1|ansible.posix      1.5.1           False           bind_mount   /home/rhel/ansible-files/mycollections/ansible_collect...
2|community.general  5.4.0           False           bind_mount   /home/rhel/ansible-files/mycollections/ansible_collect...
```

3) Now, because you installed the ansible.posix collection, you are able to lookup ansible documentation on firewalld:
```
[rhel@control ansible]$ ansible-doc firewalld
<output omitted>
```

* Done!!

[Continue to the Next Lab](04_install_roles_(EASY).md)
