<a href="https://www.youtube.com/watch?v=Oxd2Zuuv9Cs&list=PLYB6dfdhWDePZf4fd4YgGGtSX_vHKv5vz&index=14">Video Tutorial</a> by Teach Me Tech \
<a href="https://www.youtube.com/watch?v=yGJfoLGaN0E&list=PLL_setXLS0tiYMipvQI4oUGkJwhOhn42J&index=11">Video Tutorial</a> by codeXchange

***On the Control Node***

# Create an hosts.yml playbook
### QUESTION #11:
```
Instructions:

11. Download file "http://content.example.com/Rhce/myhosts.j2"
1) myhosts.j2 is having the content:
   - 127.0.0.1 localhost.localdomain localhost
   - 192.168.0.1 localhost.localdomain localhost

ii) The file should collect all node information like ipaddress,fqdn,hostname
    and it should be same as /etc/hosts file,
    if playbook is run on all the managed nodes it must store in /etc/myhosts.

Finally /etc/myhosts should like as below:
127.0.0.1 localhost.localdomain localhost
192.168.0.1 localhost.localdomain localhost

172.28.128.100   control.example.com   control
172.28.128.101   node1.example.com     node1
172.28.128.102   node2.example.com     node2
172.28.128.103   node3.example.com     node3
172.28.128.104   node4.example.com     node4
172.28.128.105   node5.example.com     node5

iii) The playbook name should be "hosts.yml" and run it on dev group.
```

(scroll down for an answer)
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>

### ANSWER #11:
1) Log into the CONTROL NODE as student, and create the "hosts.j2" file:
```

```
