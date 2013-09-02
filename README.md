scaling-archer
==============

Vagrant test bed.

Install
-------

Please refer to Instructions.md (A)

The first time will take quite a while. Vagrant will download a VirtualBox image (called a "Box") which is about 750 Mb. It will do this only once.
The box comes configured with the entire LAMP stack, BEHAT, PHANTOMJS, DRUSH (and RR), and a few other bits.


Testing BEHAT
--------------
Test BEHAT:
	
	cd /vagrant/tests/example	
	behat 

Test PHANTOM:
	
	cd /vagrant/tests/example-phantomjs
	phantom-start	
	phantom

Test JIRA:

	cd /vagrant/tests/example-jira
	sudo behat https://ikosltd.atlassian.net/
	
	
	
Connecting to MySQL
-------------------
Use ssh tunnel on port 2222, username "vagrant".
Use private key (insecure_private_key) that comes with Vagrant. For windows users it's found in 

	\users\<you>\.vagrant.d


Install a Site
--------------

Please refer to Instructions.md (B)
	

notes. (ignore this)
	
ssh -i "c:\Users\Glynn\.vagrant.d\insecure_private_key" vagrant@192.168.50.4:2222 'ls -All'
ssh -p 2222 -i c:\Users\Glynn\.vagrant.d\insecure_private_key vagrant@localhost ls -All
