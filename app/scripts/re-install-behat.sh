#!/bin/bash

echo "Trying to re-install BEHAT"
cd /usr/local/behat
php composer.phar install --prefer-dist
