Prerequisettes:
As Admin/Root:
- enable the RHEL/Rocky 9 "Developer" Repository
- yum install -y "@Virtualization Host" libvirt libvirt-devel ruby-devel gcc qemu-kvm qemu-img libxml2-devel libxslt-devel dnsmasq ebtables bridge-utils
- usermod -aG libvirt <my_username>
- exit
Run as User:
- newgrp libvirt
- vagrant plugin install vagrant-libvirt
