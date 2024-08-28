# Creating and Running VM Using VirtualBox/Vagrant in Windows
In the following, “host” refers to the physical computer that you are working on (your laptop in most cases). By “shell on host” or “host shell” we mean the Terminal program for Mac OS.

If you use Windows, we recommend that you skip Vagrant and just install VirtualBox. Instead of using Vagrant for creating and managing your VM, simply run VirtualBox and use its interface for all VM-related tasks. To create the VM, you can either download a pre-built Lubuntu 14.04 image (note the user name/password) or manually create an VM and install the operating system yourself. Remember to then set up file sharing between your VM and host by installing the VirtualBox “Guest Additions.”

## Prerequisites
Download and install the latest version of VirtualBox for Windows (PowerShell as Administrator):
```
winget install virtualbox
```
Download and install Vagrant:
```
winget install vagrant
```
Then get a shell on your host and issue the following commands to install some Vagrant plugins:
```
vagrant plugin install vagrant-vbguest
```

## Creating a VM
1) Create a ```vagrant``` directory in your local directory (%USERPROFILE%).
2) Download the file named Vagrantfile and save it in this directory. Do NOT rename the file.
3) Get a host shell and change into the directory with the Vagrantfile. Then, type this command to create (and start) the VM:
```
vagrant up
```

* NOTE: The first time it runs it will create the VM from scratch, which takes some time. (The same command will be used to restart an existing VM that has been previously stopped; that will be much faster.) As the VM starts, VirtualBox will also present you with a window showing the VM login prompt; you should just ignore that for now.

4) From your host shell, log into your VM:
```
vagrant ssh
```

You should now be in your VM shell. Follow the instructions for Help/Readying VM for the Course.
You now need to reboot your VM. Exit from from your VM shell (using the exit command), get back to your host shell, and then issue the following commands (wait for some time between the two commands):

```
vagrant halt
vagrant up
vagrant ssh
```

You shouldn’t need a password. If successful, you will be now be inside a shell on your VM. If this command hangs, hit Ctrl-C to get back to your host shell prompt, and check the VM status to see if it is ready. You can run multiple host shells and start a vagrant ssh session in each one of them to get multiple VM shells, which you can use for multitasking.

Stopping the VM:
vagrant halt
Unless explicitly stopped using the above command, your VM will keep running, which will slow your host down. Thus, we recommend that you stop your VM when you are not working on it.

Destroying the VM:
You can completely destroy your VM using another command called ```vagrant destroy```, but you will lose everything in your VM (except files in the VM directory shared with the host). Do NOT use this command unless you really want to get rid of the VM and all its data (e.g., when you finish this course).

GUI Access to VM
GUI access to VM gives you a familiar Desktop interface. To enable it, first get a VM shell via vagrant ssh, use the following command to install the necessary software on your VM:
```
/opt/dbcourse/install/install-gui.sh
```

This command will take some time. Once it’s done, exit out of your VM shell, and then reboot the VM in your host shell:
vagrant halt
vagrant up
When the VM is booted, you should now see a window showing the VM desktop with a login screen. (For convenience, you might want to make this desktop full-screen; read VirtualBox documentation for details.) Just log in as user vagrant with password vagrant.

Here is a list of useful GUI-based programs already installed on your VM. You can find them by clicking on the icon located at the lower-left corner of the VM desktop.

LXTerminal (under Accessories) gives you another VM shell. You might find it convenient to run multiple shells for multitasking.
File Manager (under Accessories) gives you a GUI for exploring folders and files on your VM.
Document Viewer (under Graphics) is for viewing PDF and images.
Chrome (under Internet) is the default Web browser. You can use it to WebSubmit files on your VM.
File Access
If you have followed the setup instructions correctly, you will find a directory named shared under your home directory on the VM. This directory automatically mirrors the directory containing the Vagrantfile on your host. For example, to work on hw01, you can make a subdirectory hw01 under the directory with Vagrantfile on your host. Then, you may create and edit a file named intro.txt inside this subdirectory (using a text editor on your host). Your VM will see this file automatically as shared/hw01/intro.txt. Inside your VM, change your working directory to shared/hw01:
cd ~/shared/hw01/
and continue your work there, e.g.:
ls -l intro.txt
nano intro.txt
Conversely, if you update anything under shared/ on your VM, you will find the changes reflected automatically on your host. Thus, you can use WebSubmit to submit such shared files from a browser on either your VM or host.

Network Access
If you had followed the above instructions to create your VM, you should be able to log into your VM via ssh from your host. To access any other network port (for example, 1234) on your VM, however, you need to setup forwarding between this port and a port on your host (say, 4321). Then, accessing your host’s port 4321 behaves just like accessing your VM’s port 1234 directly. To setup forwarding in Vagrant, follow these instructions:

If your VM is still running, log out from it (exit) and shut it down (vagrant halt).
Edit the line (or add one) beginning with config.vm.network in your Vagrantfile so it looks like follows (replace 1234 with you desired guest port and 4321 with your desired host port, respectively):
config.vm.network :forwarded_port, guest: 1234, host: 4321, auto_correct: true
Then, bring your VM back up (vagrant up). You should now be able to access your guest port through your host port.

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
