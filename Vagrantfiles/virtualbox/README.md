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
```

* If you have the python error with "curses", you can run:
```
# place it in your ~/.bashrc to make permanent
export TERM=xterm-256color
```
