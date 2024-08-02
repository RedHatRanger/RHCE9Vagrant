<a href="https://www.youtube.com/watch?v=oaeFCXhvG8w&list=PLLBLysazAN3UGnuC5Kb4HepFDZlaDGwkq&index=11">Video Tutorial</a> by HSN Tech Village \
<a href="https://www.youtube.com/watch?v=a4UEQ6db3sQ&list=PLL_setXLS0tiYMipvQI4oUGkJwhOhn42J&index=2">Video Tutorial</a> by codeXchange (BEST)

***On the Control Node***

# Configure the repository on all nodes
### QUESTION #2:
```
Instructions:

2. Create a playbook called "repo.yml" for configuring the repository on all nodes.
BaseOS:
name: BaseOS
baseurl: file:///media/BaseOS/
description: Base OS Repo
gpgcheck: yes
gpgkey: file:///media/RPM-GPG-KEY-redhat-release
enabled: yes

AppStream:
name: AppStream
baseurl: file:///media/AppStream/
description: AppStream Repo
gpgcheck: yes
gpgkey: file:///media/RPM-GPG-KEY-redhat-release
enabled: yes
```

(scroll down for an answer)
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>

### ANSWER #2:

1) Log into the CONTROL NODE as student, and create/edit a yum_repo.yml file:
```
# HINT: If you can't memorize this stuff you may run "ansible-doc yum_repository" and type /EXAMPLES to search.
        OR you may refer to docs.ansible.com 
         
[student@control ansible]$ vim yum_repo.yml

---
- name: configure yum repository
  hosts: all
  tasks:
     - name: Import a key from url
       ansible.builtin.rpm_key:
           state: present
           key: file:///media/RPM-GPG-KEY-redhat-release

     - name: configure BaseOS
       ansible.builtin.yum_repository:
           name: "OperatingSystem"
           description: "BaseOS"
           baseurl: file:///media/BaseOS
           enabled: yes
           gpgcheck: yes
           gpgkey: file:///media/RPM-GPG-KEY-redhat-release

     - name: configure AppStream
       ansible.builtin.yum_repository:
           name: "Applications"
           description: "Apps"
           baseurl: file:///media/AppStream
           enabled: yes
           gpgcheck: yes
           gpgkey: file:///media/RPM-GPG-KEY-redhat-release


:wq
```

2) OPTIONALLY YOU CAN Configure the ANSIBLE-NAVIGATOR settings, so you don't have to "ansible-playbook run -m stdout <playbook>.yml" each time:
```
vim ~/ansible/ansible-navigator.yml

ansible-navigator:
  mode: stdout

:wq
```

4) WE RUN THE PLAYBOOK:
```
[student@control ansible]$ ansible-navigator run -m stdout yum_repo.yml
<output omitted>
```

* Done!!
