<a href="https://www.youtube.com/watch?v=R0_McnbEecA&list=PLYB6dfdhWDePZf4fd4YgGGtSX_vHKv5vz&index=10">Video Tutorial</a> by Teach Me Tech

***On the Control Node***

# Create a webcontent.yml playbook
### QUESTION #8:
```
Instructions:

8. Create a playbook called webcontent.yml and it should run on dev group.
i) create a directory /devweb and it should be owned by apache group.
ii) /devweb directory should have context type as "httpd"
iii) Assign permissions for user=rwx, group=rwx, others=rx and group special permission should be applied to /devweb
iv) Create index.html file under /devweb and file should have content "Development"
v) Link /devweb to /var/www/html/devweb.
```

(scroll down for an answer)
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>

### ANSWER #8:

1) Log into the CONTROL NODE as student, and first check the firewalld service status on the dev group:
```
[student@control ansible]$ ansible dev -a "systemctl status firewalld"
```
output: \
![image](https://github.com/user-attachments/assets/e6ac741b-8332-47fa-a3e5-dae7dd132636)

2) Let's check httpd also:
```
[student@control ansible]$ ansible dev -a "systemctl status httpd"
```
output: \
![image](https://github.com/user-attachments/assets/f9b4f216-4900-4e4e-8b76-97b377cc6ee7)

3) Next, let's create the webcontent.yml file:
```
[student@control ansible]$ vim webcontent.yml

---
- name: Create a web content directory
  hosts: dev
  tasks:
         - name: create /devweb directory
           ansible.builtin.file:
                path: /devweb
                state: directory
                mode: '02775'
                group: apache
                setype: httpd_sys_content_t

         - name: create symbolic link /devweb to /var/www/html/devweb
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

          - name: allow http traffic from the firewall
            ansible.posix.firewalld:
                service: http
                permanent: true
                state: enabled
                immediate: true

:wq
```

4) Test and Run the webcontent.yml playbook:
```
[student@control ansible]$ ansible-navigator run -m stdout webcontent.yml -C
<output omitted>
[student@control ansible]$ ansible-navigator run -m stdout webcontent.yml
```
output:
![image](https://github.com/user-attachments/assets/44e5cc3c-3f97-490d-a394-e1ba513e348e)

5) Finally, let's try curling the webpage:
```
[student@control ansible]$ curl http://node1.example.com/devweb/index.html
Development[student@control ansible]$
```

* Done!!
