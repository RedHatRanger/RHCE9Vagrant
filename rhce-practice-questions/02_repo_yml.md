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

1) We can configure our ~/.vimrc file so that there is automatic indentation:
```
vim ~/.vimrc

syntax on
set bg=dark
autocmd Filetype yaml setlocal ai et ts=2 sw=2 cuc cul

:wq
```

3) For our lab, we need to set the /etc/fstab to automount /dev/sr0 to /media:
```
vim fstab.yml

---
- name: Ensure fstab entry exists
  hosts: nodes
  become: true
  tasks:
    - name: Ensure /media mount point exists
      file:
        path: /media
        state: directory

    - name: Ensure fstab entry for /dev/sr0 exists
      lineinfile:
        path: /etc/fstab
        line: '/dev/sr0  /media    iso9660    defaults 0 0'
        state: present
        create: yes

:wq
```

3) Next, we create our 1st playbook called "yum_repo.yml":
```
# HINT: If you can't memorize this stuff you may run "ansible-doc yum_repository" and type /EXAMPLES to search.
        OR you may refer to docs.ansible.com

# NOTE: On the actual exam, you may see an http://content/rhel9.0/x86_64/dvd/RPM-GPG-KEY-redhat-release being used for the GPG Keys.
         
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

4) OPTIONALLY YOU CAN Configure the ANSIBLE-NAVIGATOR settings, so you don't have to "ansible-playbook run -m stdout <playbook>.yml" each time:
```
vim ~/ansible/ansible-navigator.yml

ansible-navigator:
  mode: stdout

:wq
```

5) WE RUN THE PLAYBOOK:
```
[student@control ansible]$ ansible-navigator run -m stdout yum_repo.yml
<output omitted>
```

* Done!!
