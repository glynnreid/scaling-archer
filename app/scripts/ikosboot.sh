#!/usr/bin/env bash

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


echo 
echo "ALL DONE!"
echo "You can now login using 'vagrant ssh'"

# todo : install solr

# todo : install compass

# todo : dns settings /etc/resolvconf/resolv.conf.d/base nameserver 8.8.8.8

# todo : optomise mysql, apache, php
