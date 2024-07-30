#!/bin/bash

ansible all -m yum_repository -a 'name=EPEL description=RHEL8 baseurl=https://dl.fedoraproject.org/pub/epel/8/Everything/x86_64/ gpgkey=https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-8 enabled=yes'
