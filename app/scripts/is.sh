#!/bin/bash

# Help funtion
HELP() {
	echo ""
	echo "Usage:"
	echo "-d : Path to Drupal root Directory. No trailing slash"
	echo "-r : SQL File to Restore."	
	echo "-n : Name for this installation."
	echo "     A directory \"NAME.localhost\" will be created in PATH/sites/"
	echo "-s : Subdomain. Assumes default if not present."
	echo ""
}
# end help funtion

#If no argument given, show HELP and exit
if [ $# -lt 1 ] ;then
HELP
exit 0
fi

CODEPATH=""
DESTPATH=""
DROPDB=""
RESTORE=""
NAME=""
SUBDOMAIN=""

SUBDOMAIN_PATH=""
SUBDOMAIN_SETTINGS=""
DESTINATION=""
DESTINATION_SETTINGS=""
DBNAME=""

while getopts c:d:r:z:n:s: option
do
        case "${option}"
        in
								c) CODEPATH=${OPTARG};;
                d) DESTPATH=${OPTARG};;
                r) RESTORE=${OPTARG};;
								z) DROPDB=${OPTARG};;
                n) NAME=${OPTARG};;
								s) SUBDOMAIN=${OPTARG};;
        esac
done

# spacer 
echo

# Check path
if [ ! -d "$CODEPATH" ]; then
  echo "ERROR: Code Directory does not exist - $CODEPATH"
	exit 1
fi

# Check name
if [ -z "$NAME" ] ;then
	echo "ERROR: No Name. Please use -n to specify the name"
	exit 2
fi

if [ -z "$DESTPATH" ] ;then
	DESTPATH="/var/www/$NAME"
fi

# Check destination
DESTINATION="$DESTPATH/sites/$NAME.localhost"
DESTINATION_SETTINGS="$DESTINATION/settings.php"
if [ -d "$DESTINATION" ]; then
  echo "WARNING: DESTINATION already exists - $DESTINATION"
fi

# Check subdomain
if [ -z "$SUBDOMAIN" ] ;then
	SUBDOMAIN="default"
fi

# Build path to subdomain
SUBDOMAIN_PATH="$DESTPATH/sites/$SUBDOMAIN"

# Build path to settings file
SUBDOMAIN_SETTINGS="$CODEPATH/sites/$SUBDOMAIN/settings.php"
if [ ! -f "$SUBDOMAIN_SETTINGS" ]; then
  echo "ERROR: SETTINGS FILE does not exist - $SUBDOMAIN_SETTINGS"
	exit 5
fi

# Check RESTORE sql file
if [ ! -z "$RESTORE" ] ;then
	if [ ! -f "$RESTORE" ]; then
		echo "ERROR: File does not exist - $RESTORE"
		exit 6
	fi
fi

# Build db name
DBNAME="db_$NAME"

echo
echo "Installing new site"

echo "NAME : $NAME"
echo "CODEPATH : $CODEPATH"
echo "DESTPATH : $DESTPATH"
echo "SUBDOMAIN : $SUBDOMAIN"
echo "SUBDOMAIN_PATH : $SUBDOMAIN_PATH"
echo "SUBDOMAIN_SETTINGS : $SUBDOMAIN_SETTINGS"
echo "DESTINATION : $DESTINATION"
echo "DBNAME : $DBNAME"
echo "RESTORE : $RESTORE"
echo 
echo "WARNING! Proceeding will overwrite any existing settings and DB"
echo

read -p "Are you sure? " -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo
		echo "Not installing"
		echo 
		exit 9
fi

echo
echo
echo "Beginning installation"
echo 

# Create destination path and copy source
if [ ! -d "$DESTPATH" ]; then
	echo "Making $DESTPATH"
	mkdir $DESTPATH
fi
	
cp -R $CODEPATH/* $DESTPATH

# Create subdomain DB
if [ ! -z "$RESTORE" -o ! -z "$DROPDB" ] ;then
	echo "Dropping existing DB"
	/usr/bin/mysql -uroot -prootpass -e "DROP DATABASE IF EXISTS $DBNAME"
fi
echo "Create DB"
/usr/bin/mysql -uroot -prootpass -e "CREATE DATABASE IF NOT EXISTS $DBNAME"

# Give permissions for 'drupaluser'
echo "Grant permissions to drupaluser"
/usr/bin/mysql -uroot -prootpass -e "GRANT ALL ON $DBNAME.* TO 'drupaluser'@'localhost'"
/usr/bin/mysql -uroot -prootpass -e "flush privileges"

# Restore DB
if [ ! -z "$RESTORE" ] ;then
	echo "Restoring file : $RESTORE"
	/usr/bin/mysql -uroot -prootpass $DBNAME < $RESTORE
fi
			
# Create destination
if [ ! -z "$DESTINATION" ]; then
	if [ ! -d "$DESTINATION" ]; then
		echo "Making $DESTINATION"
		mkdir $DESTINATION
	else
		echo "$DESTINATION already exists"
	fi
fi

# Create shortcuts for files
if [ ! -d "$SUBDOMAIN_PATH/files" ]; then
	echo "$SUBDOMAIN_PATH/files does not exist, so making new"
	mkdir "$SUBDOMAIN_PATH/files"
	chown -R www-data "$SUBDOMAIN_PATH/files"
	chmod -R 755 "$SUBDOMAIN_PATH/files"
fi
if [ ! -d "$DESTINATION/files" ] && [ ! -h "$DESTINATION/files" ]; then
	echo "Making symlink for /files"
	ln -fs "$SUBDOMAIN_PATH/files" "$DESTINATION/files"
else 
	echo "/files already exists"
fi

# Create shortcuts for modules
if [ -d "$SUBDOMAIN_PATH/modules" ]; then
	if [ ! -d "$DESTINATION/modules" ] && [ ! -h "$DESTINATION/modules" ]; then
		echo "Making symlink for modules"
		ln -fs "$SUBDOMAIN_PATH/modules" "$DESTINATION/modules"
	else 
		echo "/modules already exists"
	fi
else
	if [ ! -d "$DESTINATION/modules" ]; then
		echo "Making /modules"
		mkdir "$DESTINATION/modules"
	else 
		echo "/modules already exists"
	fi
fi

# Create shortcuts for themes
if [ -d "$SUBDOMAIN_PATH/themes" ]; then
	if [ ! -d "$DESTINATION/themes" ] && [ ! -h "$DESTINATION/themes" ]; then
		echo "Making symlink for themes"
		ln -fs "$SUBDOMAIN_PATH/themes" "$DESTINATION/themes"
	else 
		echo "/themes already exists"
	fi
else
	if [ ! -d "$DESTINATION/themes" ]; then
		echo "Making /themes"
		mkdir "$DESTINATION/themes"
	else 
		echo "/themes already exists"
	fi
fi

# Create subdomain.localhost/settings.php
if [ -f $DESTINATION_SETTINGS ]; then
	mv $DESTINATION_SETTINGS "$DESTINATION/settings.php.backup"
fi

echo "Making settings file"
cat "/vagrant/app/scripts/templates/settings.template" > "temp.settings"
sed -i "s|BASEURL|http://$NAME.localhost:8888|g" "temp.settings" 
sed -i "s|DBNAME|$DBNAME|g" "temp.settings" 
mv "temp.settings" $DESTINATION_SETTINGS

		
# Create vhost 
echo "Making vhost"
VHOST="/etc/apache2/sites-available/$NAME.localhost"
if [ -f $VHOST ]; then
	sudo rm -f $VHOST
fi

cat "/vagrant/app/scripts/templates/vhost.template" > "temp.vhost"
sed -i "s|ServerName localhost|ServerName $NAME.localhost|g" "temp.vhost" 
sed -i "s|/var/www|$DESTPATH|g" "temp.vhost" 
sudo mv "temp.vhost" $VHOST
sudo a2ensite "$NAME.localhost"
# Create subdomain entry in hosts

if ! grep -q "$NAME.localhost" /etc/hosts; then
    sudo ./uh.sh add "$NAME.localhost"
fi

# Restart apache
sudo service apache2 reload

# Add exclusion to .gitignore
# TODO			

echo 
echo "ALL DONE!"
echo 

