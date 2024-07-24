<a href="https://www.youtube.com/watch?v=OXv3A2tjzWc&list=PLL_setXLS0tiYMipvQI4oUGkJwhOhn42J&index=6">Video Tutorial</a> by codeXchange

***On the Control Node***

# Create and Run a Roles.yml Playbook
### QUESTION #5:
```
Instructions:

5. Create a playbook called roles.yml and it should run balancer and phpinfo roles.

   Use roles from Ansible Galaxy
Create a playbook called /home/student/ansible/roles.yml
* The playbook contains a play that runs on host in the balancers host group and uses the balancers role.
- This role configures a service to load balance web server request between hosts in the webserver host group.
- Browsing to host in the balances host group (for example http://node5.example.com) produces the following output:
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

1) Log into the CONTROL NODE as student, and EDIT THE SECTION SO IT LOOKS LIKE THIS:
```
[student@control ansible]$ vim roles/balancer/templates/balancer.j2

...
backend app
    balance         roundrobin
  server  node3.example.com  172.28.128.103:80 check
  server  node4.example.com  172.28.128.104:80 check
...

:wq
```   
