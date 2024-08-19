```
ansible-navigator:
playbook-artifact:
enable: false
```

*vim ~/.vimrc:
```
autocmd FileType yaml setlocal ai ts=2 sw=2 et cuc nu
```

* If you want to vim a file and open it up to a certain line:
```
vim <somefile.txt> +89
```

* Ansible.cfg:
```
[defaults]
remote_user=student
inventory=/home/student/ansible/inventory
roles_path=/home/student/ansible/roles
collections_path=/home/student/ansible/mycollections
ask_pass=false
host_key_checking=false
callbacks_enabled=profile_tasks

[privilege_escalation]
become=true
become_medthod=sudo
become_user=root
become_ask_pass=false
```

* If you want to get information from remote clients:
```
ansible all -m setup
```

* PIPES WON'T WORK IN THE COMMAND MODULE:
```
If no module is specified in an adhoc command, the default command module is used. 
This module, however, cannot work with shell features such as pipes. Use the shell module instead
```

</br></br>



* Without having to type vim:
```
!v <script_name>
```

* Without having to type source ~/.bashrc:
```
. ~/.bashrc
```

* To bring up the last part of the last command that you typed, use ESC+period:
```
ESC + .
```

* If you don't want to retype a long command only to modify one word, you may use substitution:
```
systemctl status sshd
<status of the sshd service>
^status^restart
```

* In Vim, if you don't want to keep typing the #!/bin/bash statement at the top (type _sh and then space):
```
vim ~/.vimrc

abbr _sh #!/bin/bash

:wq
```

* If you forgot to run sudo in front of a command, you may use !!:
```
<previously failed command>
sudo !!
```

* If you want to start at a particular task:
```
ansible-playbook someyaml.yml --start-at-task 'Install httpd'
```

