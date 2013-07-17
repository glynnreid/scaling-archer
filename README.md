scaling-archer
==============

Vagrant test bed.

Install
-------

1. Clone this project into the root of your <projects> folder
2. Install Vagrant if you haven't already done so.	http://downloads.vagrantup.com/tags/v1.2.2
3. Install VirtualBox if you haven't already done so.	https://www.virtualbox.org/wiki/Downloads
4. Open a consol/Git bash at your <projects> folder.
5. Type "vagrant up<enter>"

The first time will take quite a while. Vagrant will download a VirtualBox image (called a "Box") which is about 270 Mb. It will do this only once.
Vagrant will then install and configure the entire LAMP stack + Behat, and a few other bits.

Note. If you see a message, at the end, similar to "[Symfony\Component\Process\Exception\RuntimeException] The process timed-out." then you will need to re-install behat.
First delete the <vender> folder and then type "php composer.phar install --prefer-source<enter>"


