#!/bin/sh
# Marcin Jasion

apt-get install python-software-properties
echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | tee -a /etc/apt/sources.list
echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | tee -a /etc/apt/sources.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886

apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db
add-apt-repository 'deb http://mariadb.mirror.nucleus.be//repo/10.0/debian wheezy main'


echo "deb http://apt.postgresql.org/pub/repos/apt/ wheezy-pgdg main" | tee -a /etc/apt/sources.list
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
echo "deb http://pkg.jenkins-ci.org/debian binary/" | tee -a /etc/apt/sources.list

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/debian-sysvinit dist 10gen' | tee -a /etc/apt/sources.list

apt-key adv --keyserver keyserver.ubuntu.com --recv-key D880C8E4
echo 'deb http://download.opensuse.org/repositories/shells:/fish:/release:/2/Debian_7.0/ ./' > /etc/apt/sources.list.d/fish-shell.list

apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C7917B12
echo "deb http://ppa.launchpad.net/chris-lea/node.js/ubuntu raring main " | tee -a /etc/apt/sources.list
echo "deb-src http://ppa.launchpad.net/chris-lea/node.js/ubuntu raring main" | tee -a /etc/apt/sources.list

apt-get update
apt-get install ntp vim nmap postgresql-9.3 mariadb-server mongodb-10gen tcpdump oracle-jdk7-installer dnsutils fish postfix nginx-extras openvpn htop iotop bwm-ng
apt-get purge nano
apt-get purge openjdk*
apt-get install maven
apt-get install jenkins


