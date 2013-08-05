#!/usr/bin/env bash
MYSQLROOTPASS="rootpass"

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
	apt-get -y install mysql-server mysql-client apache2 curl libcurl3 libcurl3-dev openjdk-7-jdk php5-mysql php5 php5-cli php5-gd php-pear php-apc php5-curl git-core build-essential openssl libssl-dev python-software-properties python g++ make npm

	touch /vagrant/app/log/aptsetup
fi
	
# configure a user for the DB
if [ ! -f /vagrant/app/log/databasesetup ];
then
    echo "CREATE USER 'drupaluser'@'localhost' IDENTIFIED BY ''" | mysql -uroot -p$MYSQLROOTPASS
    echo "CREATE DATABASE drupal" | mysql -uroot -p$MYSQLROOTPASS
    echo "GRANT ALL ON drupal.* TO 'drupaluser'@'localhost'" | mysql -uroot -pr$MYSQLROOTPASS
    echo "flush privileges" | mysql -uroot -p$MYSQLROOTPASS

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
	#rm -rf /var/www
	#ln -fs /vagrant /var/www
	
	# set group ownership to www-data
	chown -R vagrant:www-data /var/www/
	chmod -R 755 /var/www/
	
	# setup mod_rewrite
	a2enmod rewrite
	sed -i '/AllowOverride None/c AllowOverride All' /etc/apache2/sites-available/default

	# set server name
	if ! grep -q "ServerName localhost" /etc/apache2/httpd.conf; then
    echo 'ServerName localhost' >> /etc/apache2/httpd.conf
	fi
	
	# increase php default memory
	sed -i "s|memory_limit = 128M|memory_limit = 256M|g" /etc/php5/apache2/php.ini
	
	# restart apache server
	service apache2 restart
	
	touch /vagrant/app/log/wwwsetup
fi

# install behat
if [ ! -f /vagrant/app/log/behatsetup ];
then

	#npm config set registry http://registry.npmjs.org/
	
	# install n
	npm install -g n
	
	# install specific version of nodejs
	n 0.8.23
	
	mkdir /usr/local/behat
	cp /vagrant/app/downloads/composer.json /usr/local/behat/composer.json
	cd /usr/local/behat
	curl http://getcomposer.org/installer | php
	php composer.phar install --prefer-dist

	# install zombie
	npm install -g zombie@1.4.0
	
	# install missing dependency
	#npm install -g graceful-fs
		
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

# sundry stuff
if [ ! -f /vagrant/app/log/sundrystuff ];
then
	
	# make sure the scripts have the correct permissions to execute
	chmod a+x /vagrant/app/scripts/is.sh
	chmod a+x /vagrant/app/scripts/uh.sh
	
	#mkdir -p ~/tmp/solr/
	#cd ~/tmp/solr/
	#wget http://apache.ziply.com/lucene/solr/4.4.0/solr-4.4.0.tgz  
	#tar xzvf solr-4.4.0.tgz  
	
	#mkdir -p /var/solr
	#cp solr-4.4.0/dist/solr-4.4.0.war /var/solr/solr.war
	#cp -R solr-4.4.0/example/multicore/* /var/solr/
	#chown -R vagrant /var/solr/

	touch /vagrant/app/log/sundrystuff
fi

# todo : install solr

# todo : install compass

# todo : dns settings /etc/resolvconf/resolv.conf.d/base nameserver 8.8.8.8

# todo : optomise mysql, apache, php
