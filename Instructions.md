Steps to Install QMS in VM

A. Install VM

1. Make a new folder <VM> and Git Clone this project : git@github.com:ikos/scaling-archer.git
2. Install Vagrant if you haven't already done so.	http://downloads.vagrantup.com/tags/v1.2.2
3. Install VirtualBox if you haven't already done so.	https://www.virtualbox.org/wiki/Downloads
4. Open a console/Git bash at your <VM> folder.
5. Type _vagrant up<enter>_
6. Edit your ssh config file and add the following host :
		Host vagrant
		HostName localhost
		Port 2222
		User vagrant

		
B. Install Site

1. <host> Git clone the <project> to you computer in the normal manner
2. <host> Start the VM
	. Open a console/Git bash at your <VM> folder.
	. Type _vagrant up<enter>_
3. <host> Enter the VM 
	. Type _vagrant ssh_
4. <vm> Create a Git Repository in the VM to receive the code
	. git-install -n <project> { -b <git branch> }
5. <host> Add the Url received in 4 as a new Git Remote to your <project>
6. <host> Git Push code to new remote
7. <vm> site-install -n <project> { -r <path to sql file to restore> } { -d <path to drupal docroot> } { -s <subdomain> } { -z <drop DB> }
8. <host> Browser navigate to <project>.localhost:8888


C. Restore site

1. <host> Start the VM
	. Open a console/Git bash at your <VM> folder.
	. Type _vagrant up<enter>_
2. <host> Enter the VM 
	. Type _vagrant ssh_
3. <vm> site-restore -n <project> -r <path to sql file to restore>


D. Test site - Jira

1. <host> Start the VM
	. Open a console/Git bash at your <VM> folder.
	. Type _vagrant up<enter>_
2. <host> Enter the VM 
	. Type _vagrant ssh_
3. <vm> cd /var/www/<project>/tests/jira
4. <vm> sudo behat https://ikosltd.atlassian.net/

 