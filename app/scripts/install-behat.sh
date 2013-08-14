#!/bin/bash

if [ ! -f /vagrant/app/log/behatsetup ];
then
# install behat
echo "Trying to install BEHAT"
	
# install behat
mkdir /usr/local/behat
cp /vagrant/app/downloads/composer.json /usr/local/behat/composer.json
cd /usr/local/behat
curl http://getcomposer.org/installer | php
php composer.phar install --prefer-dist

# update PATH for behat
if [ ! -f /etc/profile.d/vagrant.sh ];
then
	echo 'export PATH=$PATH:/usr/local/behat/bin' >> /etc/profile.d/vagrant.sh
	echo 'export PATH=$PATH:/vagrant/app/scripts' >> /etc/profile.d/vagrant.sh
	echo 'export PATH=$PATH:/usr/local/lib/node_modules/npm/bin' >> /etc/profile.d/vagrant.sh
	echo 'export NODE_PATH=/usr/local/lib/node_modules' >> /etc/profile.d/vagrant.sh
	chmod a+x /etc/profile.d/vagrant.sh
fi

touch /vagrant/app/log/behatsetup
fi

