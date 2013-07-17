#!/usr/bin/env bash

# make a directory for vagrant logs
if [ ! -f /var/log/vagrant ];
then
	mkdir -p /var/log/vagrant
fi

# install the LAMP stack
if [ ! -f /var/log/vagrant/aptsetup ];
then

	debconf-set-selections <<< 'mysql-server mysql-server/root_password password rootpass'
	debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password rootpass'

	apt-get update
	apt-get -y install mysql-server php5-mysql apache2 php5 php5-cli
	apt-get -y install curl libcurl3 libcurl3-dev php5-curl
	apt-get -y install git-core
	
	touch /var/log/vagrant/aptsetup
fi
	
# configure a user for the DB
if [ ! -f /var/log/vagrant/databasesetup ];
then
    echo "CREATE USER 'drupaluser'@'localhost' IDENTIFIED BY ''" | mysql -uroot -prootpass
    echo "CREATE DATABASE drupal" | mysql -uroot -prootpass
    echo "GRANT ALL ON drupal.* TO 'drupaluser'@'localhost'" | mysql -uroot -prootpass
    echo "flush privileges" | mysql -uroot -prootpass

    if [ -f /vagrant/data/initial.sql ];
    then
        mysql -uroot -prootpass drupal < /vagrant/data/initial.sql
    fi
		
		touch /var/log/vagrant/databasesetup
fi

# configure web server
if [ ! -f /var/log/vagrant/wwwsetup ];
then

	# link the web server www root to the shared drive
	rm -rf /var/www
	ln -fs /vagrant /var/www

	# setup mod_rewrite
	a2enmod rewrite
	sed -i '/AllowOverride None/c AllowOverride All' /etc/apache2/sites-available/default

	# set server name
	echo 'ServerName localhost' >> /etc/apache2/httpd.conf
	# restart apache server
	service apache2 restart
	
	touch /var/log/vagrant/wwwsetup
fi

# install behat
if [ ! -f /var/log/vagrant/behatsetup ];
then
	cd /vagrant/app
	curl http://getcomposer.org/installer | php
	php composer.phar install
	cd ~
	
	touch /var/log/vagrant/behatsetup
fi

PATH=$PATH:/vagrant/app

