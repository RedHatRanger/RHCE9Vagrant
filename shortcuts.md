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
