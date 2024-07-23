Once all the nodes are up and the control node is up, on the control node:
```
[ansible@control ~]$ ssh-keygen -t rsa -b 4096
[ansible@control ~]$ for i in {1..5}; do ssh-copy-id -i ~/.ssh/id_rsa.pub ansible@172.28.128.10${i}; done
```
