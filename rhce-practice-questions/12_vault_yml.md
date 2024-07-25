<a href="https://www.youtube.com/watch?v=Hfdhnn3bHdw&list=PLYB6dfdhWDePZf4fd4YgGGtSX_vHKv5vz&index=15">Video Tutorial</a> by Teach Me Tech \
<a href="https://www.youtube.com/watch?v=ZRWzucbEoVU&list=PLL_setXLS0tiYMipvQI4oUGkJwhOhn42J&index=12">Video Tutorial</a> by codeXchange (BEST)

***On the Control Node***

# Create a vault.yml variable file
### QUESTION #12:
```
Instructions:

﻿12. Create a variable file vault.yml and that file should contain variable and its value.

  pw_developer is value Iamdev
  pw_manager is value Iammgr

  i) vault.yml file should be encrypted using password "P@ssw0rd"
  ii) store password in a file named secret.txt, which is used to encrypt the variable file.
```

(scroll down for an answer)
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>

### ANSWER #12:
1) Log into the CONTROL NODE as student, and create a "secret.txt" file in the ~/ansible folder:
```
[student@control ansible]$ vim secret.txt

P@ssw0rd

:wq
```

2) Use the "ansible-vault" command to create & encrypt the "vault.yml" using the "secret.txt" file:
```
[student@control ansible]$ ansible-vault create vault.yml --vault-password-file=secret.txt

pw_developer: Iamdev
pw_manager: Iammgr

:wq
``` 

3) View the encrypted playbook:
```
[student@control ansible]$ ansible-vault view vault.yml --vault-password-file=secret.txt
pw_developer: Iamdev
pw_manager: Iammgr
```

4) Optionally, you may configure the secret to be used each time without the --vault flag:
```
[student@control ansible]$ vim ansible.cfg

[defaults]
remote_user=student
inventory=/home/student/ansible/inventory
roles_path=/home/student/ansible/roles
collections_path=/home/student/ansible/mycollections
ask_pass=false
vault_password_file=/home/student/ansible/secret.txt

[privilege_escalation]
become=true
become_medthod=sudo
become_user=root
become_ask_pass=false

:wq
```

* Done!!
