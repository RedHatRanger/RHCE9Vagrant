ANSWER #19:
MODULES USED:
-copy

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
