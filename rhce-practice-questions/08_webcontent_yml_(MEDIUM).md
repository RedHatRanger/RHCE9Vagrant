<a href="https://www.youtube.com/watch?v=R0_McnbEecA&list=PLYB6dfdhWDePZf4fd4YgGGtSX_vHKv5vz&index=10">Video Tutorial</a> by Teach Me Tech

***On the Control Node***

# Create a webcontent.yml playbook
### QUESTION #8:
```
Instructions:

8. Create a playbook called webcontent.yml and it should run on dev group.
   i) create a directory /devweb and it should be owned by wheel group.
  ii) Assign permissions for user=rwx, group=rwx, others=rx and group special permission should be applied to /devweb.
 iii) /devweb directory should have the same selinux context type as "httpd"
  iv) Create a soft link /devweb to /var/www/html/devweb.
   v) Create index.html file under /devweb and file should have content "Development".
  vi) Allow traffic through the firewall for http.

```

(scroll down for an answer)
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>

### ANSWER #8:
MODULES USED:
- file
- copy
- ansible.posix.firewalld

1) Log into the CONTROL NODE as rhel, and create the webcontent.yml file:
```
[rhel@control ansible]$ vim webcontent.yml

---
# ansible-navigator run -m stdout webcontent.yml

- name: none for now
  hosts: dev
  tasks:
    - name: create a /devweb direectory
      file:
        path: /devweb
        state: directory
        group: wheel
        mode: 2775
        setype: httpd_sys_content_t

    - name: create symbolic link
      file:
        src: /devweb
        dest: /var/www/html/devweb
        state: link
        force: yes
    
    - name: copy using inline content
      copy:
        content: "Development"
        dest: /devweb/index.html
        setype: httpd_sys_content_t
    
    - name: allow http traffic
      ansible.posix.firewalld:
        service: http
        permanent: true
        immediate: true
        state: enabled

:wq
```

4) Test and Run the webcontent.yml playbook:
```
[rhel@control ansible]$ ansible-navigator run -m stdout webcontent.yml
```

5) Finally, let's try curling the webpage:
```
[rhel@control ansible]$ curl http://node1/devweb/index.html
```

* Done!!

[Continue to the Next Lab](09_hwreport_yml_(HARD).md)
