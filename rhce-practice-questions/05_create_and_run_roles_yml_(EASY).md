<a href="https://www.youtube.com/watch?v=OXv3A2tjzWc&list=PLL_setXLS0tiYMipvQI4oUGkJwhOhn42J&index=6">Video Tutorial</a> by codeXchange (BEST) \
<a href="https://www.youtube.com/watch?v=WEuzw1m_dCo&list=PLtt9NBONpp0MJlYGrigUukueTlp1d-rc8&index=15">Video Tutorial</a> by T_For_Tech \
<a href="https://www.youtube.com/watch?v=6pFzSNY9-fs&list=PLYB6dfdhWDePZf4fd4YgGGtSX_vHKv5vz&index=7">Video Tutorial</a> by Teach Me Tech \
<a href="https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_reuse_roles.html#using-roles-at-the-play-level">Link</a> to the Ansible Documentation

***On the Control Node***

# Create and Run a Roles.yml Playbook
### QUESTION #5:
```
Instructions:

5. Create a playbook called roles.yml and it should run balancer and phpinfo roles.

   Use roles from Ansible Galaxy
Create a playbook called /home/rhel/ansible-files/roles.yml
* The playbook contains a play that runs on host in the balancers host group and uses the balancers role.
- This role configures a service to load balance web server request between hosts in the webservers host group.
- Browsing to host in the balancers host group (for example http://node5.example.com) produces the following output:
Welcome to node3.example.com on 172.28.128.103
- Reloading the Browser produces output from the alternet web server:
Welcome to node4. lab.example.com on 172.28.128.104

* The Playbook contains a play the runs on hosts in webserver host group and uses the phpinfo role.
- Browsing to host in the webserver host group with the URL /hell.php produces the following out [ut: Hello PHP World from FQDN
- For example Browsing to http://node3.example.com/hello.php produces the following output:
Hello PHP World from node3.example.com
along with various details of the PHP configuration include the version of PHP that is installed.
- Similarly, Browsing to http://node4.lab.example.com/hello.php, produces the following output:
Hello PHP World from node4.example.com
along with various details of the PHP configuration including the version of PHP that is installed
```

(scroll down for an answer)
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>

### ANSWER #5:

1) Log into the CONTROL NODE as rhel, and Create the roles.yml file:
```
[rhel@control ansible-files]$ vim roles.yml

---
- hosts: webservers
  roles:
    - phpinfo
- hosts: balancers
  roles:
    - balancer

:wq
```

2) Adjust the "/home/rhel/ansible-files/roles/balancer/templates/balancer.j2" file:
```
#---------------------------------------------------------------------
# round robin balancing between the various backends
#---------------------------------------------------------------------
backend app
    balance     roundrobin
    server node3.example.com 172.28.128.103:80 check
    server node4.example.com 172.28.128.104:80 check

# OR WHATEVER YOUR WEBSERVERS ARE CONFIGURED AS ON THE RED HAT LAB
```

2) Test and then run the roles.yml playbook:
```
[rhel@control ansible-files]$ ansible-navigator run -m stdout roles.yml
```

4) Curl test node5 so that both node3 and node4 are balanced (Note: This may not work on RedHat Lab):
```
[rhel@control ansible-files]$ curl node5
Welcome to node3.example.com ON 172.28.128.103
[rhel@control ansible-files]$ curl node5
Welcome to node4.example.com ON 172.28.128.104
[rhel@control ansible-files]$ curl node5
Welcome to node3.example.com ON 172.28.128.103
[rhel@control ansible-files]$ curl node5
Welcome to node4.example.com ON 172.28.128.104
```

* Done!!

[Continue to the Next Lab](06_install_collections_(EASY).md)
