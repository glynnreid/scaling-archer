#!/bin/bash

# install zombie
if [ ! -f /vagrant/app/log/zombiesetup ];
then
	echo "Installing ZOMBIE"
	
	# add root user to vagrant group
	usermod -G vagrant root
	
	# give group write/execute permission for user vagrant
	chmod g+wx -R /home/vagrant
	
	# install specific version of nodejs
	npm install -g n
	
	# install missing dependency
	npm install -g graceful-fs
	
	# install node version manager (n)
	n 0.8.23

	# install zombie
	npm install -g zombie@1.4.1

	touch /vagrant/app/log/zombiesetup
fi
