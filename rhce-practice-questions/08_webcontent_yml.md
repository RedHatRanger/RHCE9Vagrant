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
![image](https://github.com/user-attachments/assets/f85b918d-c683-4190-8c08-db94e5a0d743)

2) Let's check httpd also:
```
[student@control ansible]$ ansible dev -a "systemctl status httpd"
```
output: \
![image](https://github.com/user-attachments/assets/f9b4f216-4900-4e4e-8b76-97b377cc6ee7)
