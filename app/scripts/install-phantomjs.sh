#!/bin/bash

echo "Tring to install phantomjs"
cd /usr/local/share

wget https://phantomjs.googlecode.com/files/phantomjs-1.9.1-linux-x86_64.tar.bz2 
tar xjf phantomjs-1.9.1-linux-x86_64.tar.bz2 

ln -s /usr/local/share/phantomjs-1.9.1-linux-x86_64/bin/phantomjs /usr/local/share/phantomjs; 
ln -s /usr/local/share/phantomjs-1.9.1-linux-x86_64/bin/phantomjs /usr/local/bin/phantomjs; 
ln -s /usr/local/share/phantomjs-1.9.1-linux-x86_64/bin/phantomjs /usr/bin/phantomjs
