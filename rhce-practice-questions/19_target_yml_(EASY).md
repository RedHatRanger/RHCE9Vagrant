***On the Control Node***

# Change the Default Boot Target
### QUESTION #3:
```
Instructions:

4. Install the roles
i) create directory "roles" under /home/student/ansible
ii) create a "requirements.yml" under the roles directory and download the given roles under it using the galaxy command.
iii) 1st role name should be "balancer" and download it using this url "http://content.example.com/rhce/balancer.tgz".
iv)  2nd role name will be "phpinfo" and download it using this url "http://content.example.com/rhce/phpinfo.tgz".

For this example we will use (This part will not be on the exam, but for real exam you will use WGET for the content files):
https://github.com/bbatsche/Ansible-PHP-Site-Role.git            (phpinfo)
https://github.com/geerlingguy/ansible-role-haproxy.git            (balancer)

* Note: You can find them on galaxy.ansible.com and search for the roles "geerlingguy.haproxy" and "bagaswh.php".
        Then you can open their github pages and copy the https link.
```

(scroll down for an answer)
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>

### ANSWER #19:
MODULES USED:
-copy

1. Log into the control node and create the target.yml:
```
vim target.yml

---
- name: boot target
  hosts: all
  tasks:
    - name: set default boot target
      file:
        state: link
        src:  /usr/lib/systemd/system/multi-user.target
        dest: /etc/systemd/system/default.target

:wq
```

2. Test and run the "target.yml":
```
[student@control ansible]$ ansible-navigator run -m stdout target.yml
```

* Done!!
