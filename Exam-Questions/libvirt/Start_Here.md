Prerequisettes:
As Admin/Root:
- enable the RHEL/Rocky 9 "Developer" Repository
- yum install libvirt-devel
- usermod -aG libvirt $(whoami)
- exit
Run as User:
- newgrp libvirt
- vagrant plugin install vagrant-libvirt
