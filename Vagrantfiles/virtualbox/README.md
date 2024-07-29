* Edit the /etc/fstab to automount the RHEL DVD ISO:
```
[student@control ~]$ sudo vim /etc/fstab

/dev/sr0    /media     iso9660    defaults 0 0

:wq
```

* Mount the filesystem:
```
[student@control ~]$ sudo systemctl daemon-reload
[student@control ~]$ sudo mount -a
```

* Create the local repo from the RHEL DVD ISO:
```
[student@control ~]$ sudo vim /etc/yum.repos.d/myrepo.repo

[BaseOS]
name=BaseOS
baseurl=file:///media/BaseOS
enabled=1
gpgcheck=1
gpgkey=file:///media/RPM-GPG-KEY-redhat-release

[AppStream]
name=AppStream
baseurl=file:///media/AppStream
enabled=1
gpgcheck=1
gpgkey=file:///media/RPM-GPG-KEY-redhat-release

:wq
```

* Install container-tools, python3-pip, and ansible-core:
```
[student@control ~]$ sudo yum install -y ansible-core container-tools python3-pip
```

* If you have the python error with "curses", you can run:
```
# place it in your ~/.bashrc to make permanent
export TERM=xterm-256color
```
