1) If you want a playbook to start at a particular task, you can run:
### ansible-playbook someyaml.yml --start-at-task 'Install httpd'

* Running this will only run the playbook from that point on. 
