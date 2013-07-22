#!/usr/bin/env bash

# make a directory for vagrant logs
if [ ! -f /vagrant/app/log ];
then
	mkdir -p /vagrant/app/log
fi

# install the LAMP stack
if [ ! -f /vagrant/app/log/aptsetup ];
then

	debconf-set-selections <<< 'mysql-server mysql-server/root_password password rootpass'
	debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password rootpass'

	apt-get update
	apt-get -y install mysql-server mysql-client apache2
	apt-get -y install php5-mysql php5 php5-cli php5-gd php-pear php-apc
	apt-get -y install curl libcurl3 libcurl3-dev php5-curl
	apt-get -y install git-core
	
	touch /vagrant/app/log/aptsetup
fi
	
# configure a user for the DB
if [ ! -f /vagrant/app/log/databasesetup ];
then
    echo "CREATE USER 'drupaluser'@'localhost' IDENTIFIED BY ''" | mysql -uroot -prootpass
    echo "CREATE DATABASE drupal" | mysql -uroot -prootpass
    echo "GRANT ALL ON drupal.* TO 'drupaluser'@'localhost'" | mysql -uroot -prootpass
    echo "flush privileges" | mysql -uroot -prootpass

    if [ -f /vagrant/data/initial.sql ];
    then
        mysql -uroot -prootpass drupal < /vagrant/data/initial.sql
    fi
		
		touch /vagrant/app/log/databasesetup
fi

# configure web server
if [ ! -f /vagrant/app/log/wwwsetup ];
then

	# link the web server www root to the shared drive
	rm -rf /var/www
	ln -fs /vagrant /var/www
	
	# set group ownership to www-data
	chown -R www-data /var/www/
	chmod -R 755 /var/www/
	
	# setup mod_rewrite
	a2enmod rewrite
	sed -i '/AllowOverride None/c AllowOverride All' /etc/apache2/sites-available/default

	# set server name
	echo 'ServerName localhost' >> /etc/apache2/httpd.conf
	
	# increase php default memory
	sed -i "s|memory_limit = 128M|memory_limit = 512M|g" /etc/php5/apache2/php.ini
	
	# restart apache server
	service apache2 restart
	
	touch /vagrant/app/log/wwwsetup
fi

# install behat
if [ ! -f /vagrant/app/log/behatsetup ];
then
	cd /vagrant/app
	curl http://getcomposer.org/installer | php
	php composer.phar install
	cd ~
	
	# update PATH for behat
	if [ ! -f /etc/profile.d/behat.sh ];
	then
		echo 'PATH=$PATH:/vagrant/app' >> /etc/profile.d/behat.sh
	fi

	touch /vagrant/app/log/behatsetup
fi

# todo : install solr

# todo : install compass

# todo : permissions on created folders

# todo : dns settings /etc/resolvconf/resolv.conf.d/base nameserver 8.8.8.8
