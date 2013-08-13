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

The first time will take quite a while. Vagrant will download a VirtualBox image (called a "Box") which is about 270 Mb. It will do this only once.
Vagrant will then install and configure the entire LAMP stack, and a few other bits.

To install BEHAT :

	sudo /vagrant/app/scripts/install-behat.sh

IF the BEHAT installation fails, you can retry with:

	sudo /vagrant/app/scripts/re-install-behat.sh

Test BEHAT:
	
	cd /vagrant/tests/example	
	behat 


To install ZOMBIE:
	
	sudo /vagrant/app/scripts/install-zombie.sh

Test ZOMBIE:

	cd /vagrant/tests/example-zombie
	behat 



To install PHANTOM:
	
	sudo /vagrant/app/scripts/install-phantomjs.sh

Test PHANTOM:
	
	cd /vagrant/tests/example-phantomjs
	phantomjs --webdriver=8643 &
	behat -p phantomjs


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


