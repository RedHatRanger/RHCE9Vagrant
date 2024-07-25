<a href="https://www.youtube.com/watch?v=icqzQA6-7dU&list=PLYB6dfdhWDePZf4fd4YgGGtSX_vHKv5vz&index=17">Video Tutorial</a> by Teach Me Tech \
<a href="https://www.youtube.com/watch?v=ZrZDEMCsQLw&list=PLL_setXLS0tiYMipvQI4oUGkJwhOhn42J&index=14">Video Tutorial</a> by codeXchange (BEST)

***On the Control Node***

# Rekey the encrypted file solaris.yml
### QUESTION #14:
```
Instructions:

14. Rekey variable file from "http://content.example.com/Rhce/solaris.yml"

i) Old password: cisco
ii) New password: redhat
```

(scroll down for an answer)
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>

### ANSWER #14:
1) Log into the CONTROL NODE as student, and run "wget" to download the "solaris.yml" file:
```
# This wget is only required for the exam
[student@control ansible]$ ﻿wget http://content.example.com/Rhce/solaris.yml
```
output: \
![image](https://github.com/user-attachments/assets/a860dfd2-5ed6-4c95-855f-cab88f35ae43)

2) In order to practice for the exam you need to first create the "solaris.yml" file:
```
NOTE:
# PASSWORD = cisco

[student@control ansible]$ ansible-vault create solaris.yml
New Vault password:
Confirm New Vault password:

aaaaaaaaaaaaa
bbbbbbbbbbbbb
ccccccccccccc

:wq
```

3) Finally, run the "ansible-vault rekey" command to change the password on "solaris.yml":
```
NOTE:
# OLD PASSWORD = cisco
# NEW PASSWORD = redhat

[student@control ansible]$ ansible-vault rekey solaris.yml
Vault password:
New Vault password:
Confirm New Vault password:
Rekey successful
[student@control ansible]$
```

* Done!!
