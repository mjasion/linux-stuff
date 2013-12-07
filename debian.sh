#!/bin/sh
# Marcin Jasion

if [ $USER != 'root' ]; then
        echo "Sorry, you need to run this as root"
        exit
fi

apt-get install python-software-properties

# oracle java
echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" >> /etc/apt/sources.list.d/oracle-java.list
echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" >> /etc/apt/sources.list.d/oracle-java.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886

# mariadb
echo "deb http://mariadb.mirror.nucleus.be//repo/10.0/debian wheezy main" >> /etc/apt/sources.list.d/mariadb.list
apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db

# postgresql
echo "deb http://apt.postgresql.org/pub/repos/apt/ wheezy-pgdg main" >> /etc/apt/sources.list.d/postgresql.list
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

# jenkins
echo "deb http://pkg.jenkins-ci.org/debian binary/" >> /etc/apt/sources.list.d/jenkins.list
wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -

# mongodb
echo 'deb http://downloads-distro.mongodb.org/repo/debian-sysvinit dist 10gen' >> /etc/apt/sources.list.d/mongodb.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10

# fish shell
echo 'deb http://download.opensuse.org/repositories/shells:/fish:/release:/2/Debian_7.0/ ./' >> /etc/apt/sources.list.d/fish-shell.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-key D880C8E4

# node.js
echo "deb http://ppa.launchpad.net/chris-lea/node.js/ubuntu raring main " >> /etc/apt/sources.list.d/nodejs.list
echo "deb-src http://ppa.launchpad.net/chris-lea/node.js/ubuntu raring main" >> /etc/apt/sources.list.d/nodejs.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C7917B12

# git
echo "deb http://ppa.launchpad.net/git-core/ppa/ubuntu saucy main" >> /etc/apt/sources.list.d/git.list
echo "deb-src http://ppa.launchpad.net/git-core/ppa/ubuntu saucy main" >> /etc/apt/sources.list.d/git.list

apt-get update
apt-get install ntp vim nmap postgresql-9.3 mariadb-server mongodb-10gen tcpdump oracle-jdk7-installer dnsutils fish postfix nginx-extras openvpn htop iotop bwm-ng git gitk subversion nodejs jenkins maven
apt-get purge nano 
apt-get purge openjdk*