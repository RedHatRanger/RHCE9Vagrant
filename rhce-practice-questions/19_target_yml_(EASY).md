***On the Control Node***

# Change the Default Boot Target
### QUESTION #19:
```
Instructions:

19. Set the default boot target to multi-user.target
i) create a playbook called "target.yml" to set the default.target
```

(scroll down for an answer)
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>

### ANSWER #19:
MODULES USED:
- file

1. Log into the control node and create the target.yml:
```
vim target.yml

---
- name: boot target
  hosts: all
  tasks:
    - name: set default boot target
      file:
        state: link
        src:  /usr/lib/systemd/system/multi-user.target
        dest: /etc/systemd/system/default.target

:wq
```

2. Test and run the "target.yml":
```
[student@control ansible]$ ansible-navigator run -m stdout target.yml
```

* Done!!
