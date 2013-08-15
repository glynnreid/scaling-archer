scaling-archer
==============

Vagrant test bed.

Install
-------

1. Clone this project into the root of your <projects> folder
2. Install Vagrant if you haven't already done so.	http://downloads.vagrantup.com/tags/v1.2.2
3. Install VirtualBox if you haven't already done so.	https://www.virtualbox.org/wiki/Downloads
4. Open a consol/Git bash at your <projects> folder.
5. Type _vagrant up<enter>_

The first time will take quite a while. Vagrant will download a VirtualBox image (called a "Box") which is about 750 Mb. It will do this only once.
The box comes configured with the entire LAMP stack, BEHAT, PHANTOMJS, DRUSH (and RR), and a few other bits.

New* 

Now has a static IP : 192.168.50.4 and a git repository available as 
	
	vagrant@192.168.50.4:code.git


Testing BEHAT
--------------
Test BEHAT:
	
	cd /vagrant/tests/example	
	behat 

Test PHANTOM:
	
	cd /vagrant/tests/example-phantomjs
	phantom.start.sh	
	phantom.sh 


Connecting to MySQL
-------------------
Use ssh tunnel on port 2222, username "vagrant".
Use private key (insecure_private_key) that comes with Vagrant. For windows users it's found in 

	\users\<you>\.vagrant.d


Install a Site
--------------
Important! For windows users - you must run cmd prompt as Administrator

Options:
-n : Name
-c : Code path (full path)
-d : Destination path (full path, optional)
-r : Restore DB file (full path, optional)
-s : Subdomain (optional, default "default")
-z : optionally drop the DB first

Examples

	./is.sh -n soa -c /vagrant/soa -r /var/www/soa/prod-soa-soa-2013-07-17.sql -z=yes

	./is.sh -n soa -c /vagrant/soa



