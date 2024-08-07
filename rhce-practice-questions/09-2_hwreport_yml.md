<a href="https://www.youtube.com/watch?v=7-hhX6rcuvY&list=PLYB6dfdhWDePZf4fd4YgGGtSX_vHKv5vz&index=12">Video Tutorial</a> by Teach Me Tech \
<a href="https://www.youtube.com/watch?v=m5KhsZonGBY&list=PLL_setXLS0tiYMipvQI4oUGkJwhOhn42J&index=9">Video Tutorial</a> by codeXchange \
<a href="https://www.youtube.com/watch?v=8gOgJbQ29Bc">Video Tutorial</a> by Silent Solution (BEST)


***On the Control Node***

# Create a hwreport.yml playbook
### QUESTION #9:
```
Instructions:

9. Collect a hardware report using a playbook on all nodes.
i) download hwreport.txt from the url "http://content.example.com/hwreport.txt and save it under /root.

/root/hwreport.txt should have content with node information as key=value
#hwreport
HOSTNAME=
MEMORY=
BIOS=
DISK_SIZE_SDA=
DISK_SIZE_SDB=
ii) if there is no information it should show "NONE"
iii) playbook name should be hwreport.yml
```

(scroll down for an answer)
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>

### ANSWER #9:
1) Log into the CONTROL NODE as student, and create the "hwreport.empty" file in the ~/ansible directory:
```
[student@control ansible]$ vim hwreport.empty
﻿
HOSTNAME= inventoryhostname
MEMORY= memory_in_MB
BIOS= BIOS_version
DISK_SIZE_SDA= disk_sda_size
DISK_SIZE_SDB= disk_sdb_size
```

1) Next, create the "hwreport.yml" file:
```
# NOTE: If you are unsure you can run "ansible-doc get_url" and search /EXAMPLES for Download foo.conf
  AND "ansible-doc copy" for information and EXAMPLES for the copy command.
  AND "ansible all -m setup > test" will get you the correct parameters you are looking for the replace: option.

[student@control ansible]$ vim hwreport.yml
```
---
- name: Collect hardware report
  hosts: all
  become: yes
  tasks:
    - name: Download hwreport.txt
      get_url:
        url: http://content.example.com/hwreport.txt
        dest: /root/hwreport.txt
        mode: '0644'

    - name: Gather hardware information
      set_fact:
        hostname: "{{ ansible_hostname }}"
        memory: "{{ ansible_memtotal_mb | default('NONE') }} MB"
        bios: "{{ ansible_facts.bios_version | default('NONE') }}"
        disk_size_sda: "{{ ansible_facts.disks.sda.size | default('NONE') }} GB"
        disk_size_sdb: "{{ ansible_facts.disks.sdb.size | default('NONE') }} GB"

    - name: Create a hardware report
      copy:
        content: |
          #hwreport
          HOSTNAME={{ hostname }}
          MEMORY={{ memory }}
          BIOS={{ bios }}
          DISK_SIZE_SDA={{ disk_size_sda }}
          DISK_SIZE_SDB={{ disk_size_sdb }}
        dest: /root/hwreport.txt
        mode: '0644'
```

2) Test and run the hwreport.yml playbook:
```
[student@control ansible]$ ansible-navigator run -m stdout hwreport.yml -C
<output omitted>
[student@control ansible]$ ansible-navigator run -m stdout hwreport.yml
﻿...
TASK [Downlod this file] *************************************************************
changed: [node3.example.com]
changed: [node5.example.com]
changed: [node4.example.com]
changed: [node2.example.com]
changed: [node1.example.com]

TASK [Generate information for the Inventory hostname] *****************
changed: [node4.example.com]
changed: [node3.example.com]
changed: [node5.example.com]
changed: [node2.example.com]
changed: [node1.example.com]

TASK [Generate information for memory_in_MB] *******
changed: [node3.example.com]
changed: [node5.example.com]
changed: [node4.example.com]
changed: [node1.example.com]
changed: [node2.example.com]

TASK [Generate information for BIOS_version] ****
changed: [node5.example.com]
changed: [node3.example.com]
changed: [node4.example.com]
changed: [node1.example.com]
changed: [node2.example.com]
TASK [Generate information for disk_sda_size]
...
```

* Validate the /root/hwreport.txt file for each of the nodes:
```
[student@control ansible]$ ansible all -m command -a "cat /root/hwreport.txt"
<output omitted>
```

* Done!!
