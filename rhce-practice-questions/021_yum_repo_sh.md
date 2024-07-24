<a href="https://www.youtube.com/watch?v=iCWa4Me0ykM">Video Tutorial</a> by Nehra Classes

***On the Control Node***

# Configure the repository on all nodes
### QUESTION #2:
```
Instructions:

2. Create and run an Ansible ad-hoc command.  As a system administrator, you need to install software on the managed nodes:
a) Create a shell script called yum-repo.sh that runs Ansible ad-hoc commands to create the yum repositories
   on each of the managed nodes as per the following details:
b) NOTE: you need to create 2 repos (BaseOS & AppStream) in the managed nodes.
BaseOS:
name: BaseOS
baseurl: file:///mnt/BaseOS/
description: Base OS Repo
gpgcheck: no
enabled: yes
AppStream:
name: AppStream
baseurl: file:///mnt/AppStream/
description: AppStream Repo
gpgcheck: no
enabled: yes
```

(scroll down for an answer)
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>

### ANSWER #2:

1) Log into the CONTROL NODE as student, and create/edit a yum_repo.yml file:
```
[student@control ansible]$ ansible all -m command -a 'yum repolist all'
[student@control ansible]$ vim yum-repo.sh

#!/bin/bash
ansible all -b -m yum_repository -a 'file=external.repo name=BaseOS description="Base OS Repo" baseurl=file:///mnt/BaseOS/ gpgcheck=no enabled=yes state=present'
ansible all -b -m yum_repository -a 'file=external.repo name=AppStream description="AppStream Repo" baseurl=file:///mnt/AppStream/ gpgcheck=no enabled=yes state=present'

:wq
```

```
[student@control ansible]$ chmod +x yum-repo.sh
[student@control ansible]$ ./yum-repo.sh
[student@control ansible]$ ansible all -m command -a 'yum repolist all'
```

* Done!!
