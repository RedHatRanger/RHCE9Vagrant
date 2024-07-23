<a href="https://www.youtube.com/watch?v=3zV89O7azb0&list=PLYB6dfdhWDePZf4fd4YgGGtSX_vHKv5vz&index=3">Video Tutorial</a> by Teach Me Tech

***On the Control Node***

# Configure the repository on all nodes
### QUESTION #2:
```
Instructions:

2. Create a playbook yum_repo.yml for configuring repository on all nodes
```

(scroll down for an answer)
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>

### ANSWER #2:

1) Log into the CONTROL NODE as student, and create/edit a yum_repo.yml file:
```
[student@control ansible]$ vim yum_repo.yml

---
- name: configure yum
  hosts: all
  tasks:
     - name: configure AppStream
       ansible.builtin.yum_repository:
           name: "Applications"
           description: "Apps"
           baseurl: file:///media/AppStream
           enabled: yes
           gpgcheck: 0
           # gpgcheck: http://content......

     - name: configure BaseOS
       ansible.builtin.yum_repository:
           name: "Applications"
           description: "BaseOS"
           baseurl: file:///media/BaseOS
           enabled: yes
           gpgcheck: 0
           # gpgcheck: http://content......

:wq
```

2) Configure the ansible-navigator.yml settings, so you don't have to type the "ansible-playbook run -m stdout <playbook>.yml" each time:
```

``` 
4) WE RUN THE PLAYBOOK:
```
[student@control ansible]$ ansible-navigator run yum_repo.yml
```

4) Clean the current repos on all the nodes FROM THE CONTROL NODE, then gather the repolists:
```
[student@control ansible]$ ansible all -m command -a "yum clean all"
<output omitted>

[student@control ansible]$ ansible all -m command -a "yum repolist all"
<output omitted>
```
