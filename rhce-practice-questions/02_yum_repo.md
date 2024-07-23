<a href="https://www.youtube.com/watch?v=3zV89O7azb0&list=PLYB6dfdhWDePZf4fd4YgGGtSX_vHKv5vz&index=3">Video Tutorial</a> by Teach Me Tech

***On the Control Node***

# Configure the repository on all nodes
### QUESTION #2:
```
Instructions:

control node: control.example.com

managed nodes:
              node1.example.com
              node2.example.com
              node3.example.com
              node4.example.com
              node5.example.com
* All nodes root password is "redhat" and Ansible control node username is student with passowrd "redhat".

* create directory "ansible" under path /home/student/ and all playbooks should be under /home/student/ansible.

* all playbooks should be owned by student and ansible managed node username is also student.

* Unless advised password should be "redhat" for all the users.

Ansible Automation Platform (AAP) 2.2 is utility.example.com credentials are admin, redhat.

Note: In exam, if they have not given managed node username, in that case, user control node user as remote user.
-------------------------------------------------------------------------------------
# ssh student@workstation

2. Create a playbook yum_repo.yml for configuring repository on all nodes
```

(scroll down for an answer)
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>

### ANSWER #2:

1) Log into the CONTROL NODE as student, and 
