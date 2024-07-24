<a href="https://www.youtube.com/watch?v=7-hhX6rcuvY&list=PLYB6dfdhWDePZf4fd4YgGGtSX_vHKv5vz&index=12">Video Tutorial</a> by Teach Me Tech \
<a href="https://www.youtube.com/watch?v=m5KhsZonGBY&list=PLL_setXLS0tiYMipvQI4oUGkJwhOhn42J&index=9">Video Tutorial</a> by codeXchange

***On the Control Node***

# Create a hwreport.yml playbook
### QUESTION #9:
```
Instructions:

9. Collect a hardware report using a playbook on all nodes.
i) download hwreport.txt from the url "http://content.example.com/hwreport.txt and save it under /root.

/root/hwreport.txt should have content with node information as key=value
#hwreport
HOSTNAME=
MEMORY=
BIOS=
CPU=
DISK_SIZE_VDA=
DISK_SIZE_VDB=
ii) if there is no information it should show "NONE"
iii) playbook name should be hwreport.yml
```

(scroll down for an answer)
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>

### ANSWER #9:

1) Log into the CONTROL NODE as student, and create the hwreport.yml:
```
[student@control ansible]$ vim hwreport.yml
```
file contents: \
![image](https://github.com/user-attachments/assets/9a4950d4-3da6-4f95-9685-6d18220076af)

2) Test and run the hwreport.yml playbook:
```
[student@control ansible]$ ansible-navigator run -m stdout hwreport.yml -C
<output omitted>
[student@control ansible]$ ansible-navigator run -m stdout hwreport.yml
```
output: \
![image](https://github.com/user-attachments/assets/625aace1-5c6f-449c-97e4-6cd2c8977c6c)

