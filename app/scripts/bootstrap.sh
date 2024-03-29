#!/usr/bin/env bash
MYSQLROOTPASS="rootpass"


if [ ! -f /vagrant/app/log/initsetup ];
then
  # make a directory for vagrant logs
  if [ ! -f /vagrant/app/log ];
  then
	  mkdir -p /vagrant/app/log
  fi

  # make sure the scripts have the correct permissions to execute
  chmod a+x /vagrant/app/scripts/*.sh

  touch /vagrant/app/log/initsetup
fi

# install the LAMP stack
if [ ! -f /vagrant/app/log/aptsetup ];
then

	debconf-set-selections <<< "mysql-server mysql-server/root_password password $MYSQLROOTPASS"
	debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $MYSQLROOTPASS"

	apt-get update
	apt-get -y install mysql-server mysql-client apache2 curl libcurl3 libcurl3-dev openjdk-7-jdk php5-mysql php5 php5-cli php5-gd php-pear php-apc php5-curl git-core build-essential openssl libssl-dev python-software-properties python g++ make npm

	touch /vagrant/app/log/aptsetup
fi
	
# configure a user for the DB
if [ ! -f /vagrant/app/log/databasesetup ];
then
    echo "CREATE USER 'drupaluser'@'localhost' IDENTIFIED BY ''" | mysql -uroot -p$MYSQLROOTPASS
    echo "CREATE DATABASE drupal" | mysql -uroot -p$MYSQLROOTPASS
    echo "GRANT ALL ON drupal.* TO 'drupaluser'@'localhost'" | mysql -uroot -p$MYSQLROOTPASS
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

# sundry stuff
if [ ! -f /vagrant/app/log/sundrystuff ];
then

  # install drush
	pear channel-discover pear.drush.org
	pear install drush/drush
	drush version

	drush dl registry_rebuild
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

echo 
echo "ALL DONE!"
echo "You can now login using 'vagrant ssh'"

# todo : install solr

# todo : install compass

# todo : dns settings /etc/resolvconf/resolv.conf.d/base nameserver 8.8.8.8

# todo : optomise mysql, apache, php
