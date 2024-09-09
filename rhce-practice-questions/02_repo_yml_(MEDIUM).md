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
MODULES USED:
- yum_repository
- rpm_key
- file
- lineinfile

</br></br>
## Start Here
3) Next, we create our 1st playbook called "repo.yml":
```
# HINT: If you can't memorize this stuff you may run "ansible-doc yum_repository"
        and type /EXAM to search.
        OR you may refer to docs.ansible.com

# NOTE: On the actual exam, you may see:
http://content/rhel9.0/x86_64/dvd/RPM-GPG-KEY-redhat-release being used for the GPG Keys.
         
[rhel@control ansible]$ vim repo.yml
```
```yaml
---
# ansible-navigator run -m stdout repo.yml
- name: my repo
  hosts: all
  tasks:
    - name: Import a key from a url
      ansible.builtin.rpm_key:
          state: present
          key: /media/RPM-GPG-KEY-redhat-release

    - name: Add BaseOS Repo
      ansible.builtin.yum_repository:
          name: BaseOS
          description: BaseOS
          file: myrepo
          baseurl: file:///media/BaseOS
          gpgcheck: yes
          enabled: yes
          gpgkey: file:///media/RPM-GPG-KEY-redhat-release

    - name: Add AppStream Repo
      ansible.builtin.yum_repository:
          name: AppStream
          description: AppStream
          file: myrepo
          baseurl: file:///media/AppStream
          gpgcheck: yes
          enabled: yes
          gpgkey: file:///media/RPM-GPG-KEY-redhat-release
```

5) WE RUN THE PLAYBOOK:
```
[rhel@control ansible]$ ansible-navigator run -m stdout repo.yml
```

* Done!!

[Continue to the Next Lab](03_install_roles_(EASY).md)

</br></br></br></br></br></br></br></br></br></br></br></br></br></br></br></br>

OPTIONALLY YOU CAN create an alias for ANSIBLE-NAVIGATOR so you don't have to "ansible-playbook run -m stdout" every time:
```
echo "alias nav='ansible-playbook run -m stdout'" >> ~/.bashrc; . ~/.bashrc
```
