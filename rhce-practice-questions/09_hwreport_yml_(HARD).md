<a href="https://www.youtube.com/watch?v=7-hhX6rcuvY&list=PLYB6dfdhWDePZf4fd4YgGGtSX_vHKv5vz&index=12">Video Tutorial</a> by Teach Me Tech \
<a href="https://www.youtube.com/watch?v=m5KhsZonGBY&list=PLL_setXLS0tiYMipvQI4oUGkJwhOhn42J&index=9">Video Tutorial</a> by codeXchange \
<a href="https://www.youtube.com/watch?v=8gOgJbQ29Bc">Video Tutorial</a> by Silent Solution (BEST)


***On the Control Node***

# Create a hwreport.yml playbook
### QUESTION #9:
```
Instructions:

9. Collect a hardware report using a playbook on all nodes.
  i)   Download "hwreport.txt" from the url "http://content.example.com/hwreport.txt" and save it under /root.
  ii)  If there is no information it should show "NONE"
  iii) The name of the laybook should be "hwreport.yml"


                                    *** NOTE ***:
For this example we will download the file from:
https://raw.githubusercontent.com/RedHatRanger/RHCE9Vagrant/main/rhce-practice-questions/golden_files/hwreport.txt

/root/hwreport.txt should have content with node information as key=value
#hwreport
HOSTNAME=
MEMORY=
BIOS=
DISK_SIZE_SDA=
DISK_SIZE_SDB=
```

(scroll down for an answer)
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>

### ANSWER #9:
MODULES USED:
- get_url
- replace
- You will use "ansible-doc get_url" and "ansible-doc replace" for the syntax

</br></br>

1) Create the "hwreport.yml" file:
```
# NOTE: If you are unsure you can run "ansible-doc get_url" and search /EXAMPLES for Download foo.conf
# AND "ansible all -m setup > test" will get you the correct parameters you are looking for the replace: option.

[student@control ansible]$ vim hwreport.yml

---
- name: Generate a hardware report
  hosts: all
  become: true
  tasks:
    - name: Get the file from the url
      ansible.builtin.get_url:
        url: https://raw.githubusercontent.com/RedHatRanger/RHCE9Vagrant/main/rhce-practice-questions/golden_files/hwreport.txt
        dest: /root/hwreport.txt
        mode: '0755'

    - name: Generate information for the Inventory hostname
      ansible.builtin.replace:
        path: /root/hwreport.txt
        regexp: "inventoryhostname"
        replace: "{{ ansible_hostname | default ('NONE') }}"

    - name: Generate information for memory_in_MB
      ansible.builtin.replace:
        path: /root/hwreport.txt
        regexp: "memory_in_MB"
        replace: "{{ ansible_memory_mb.real.free | default ('NONE') }}"

    - name: Generate information for BIOS_version
      ansible.builtin.replace:
        path: /root/hwreport.txt
        regexp: "BIOS_version"
        replace: "{{ ansible_bios_version | default ('NONE') }}"

    - name: Generate information for disk_sda_size
      ansible.builtin.replace:
        path: /root/hwreport.txt
        regexp: "disk_sda_size"
        replace: "{{ ansible_devices.sda.size | default ('NONE') }}"

    - name: Generate information for disk_sdb_size
      ansible.builtin.replace:
        path: /root/hwreport.txt
        regexp: "disk_sdb_size"
        replace: "{{ ansible_devices.sdb.size | default ('NONE') }}"
```

2) Test and run the hwreport.yml playbook:
```
[student@control ansible]$ ansible-navigator run -m stdout hwreport.yml
﻿<output omitted>
```

* Validate the /root/hwreport.txt file for each of the nodes:
```
[student@control ansible]$ ansible all -m shell -a "cat /root/hwreport.txt; echo ' '"
<output omitted>
```

* Done!!