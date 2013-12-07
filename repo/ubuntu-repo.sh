#!/bin/sh
# Marcin Jasion

# oracle java
rm /etc/apt/sources.list.d/oracle-java.list
echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" >> /etc/apt/sources.list.d/oracle-java.list
echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" >> /etc/apt/sources.list.d/oracle-java.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886

# mariadb
rm /etc/apt/sources.list.d/mariadb.list
echo "deb http://mariadb.cu.be//repo/10.0/ubuntu saucy main" >> /etc/apt/sources.list.d/mariadb.list
echo "deb-src http://mariadb.cu.be//repo/10.0/ubuntu saucy main" >> /etc/apt/sources.list.d/mariadb.list
apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db

# postgresql
rm /etc/apt/sources.list.d/postgresql.list
echo "deb http://apt.postgresql.org/pub/repos/apt/ wheezy-pgdg main" >> /etc/apt/sources.list.d/postgresql.list
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

# jenkins
rm /etc/apt/sources.list.d/jenkins.list
echo "deb http://pkg.jenkins-ci.org/debian binary/" >> /etc/apt/sources.list.d/jenkins.list
wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -

# mongodb
rm /etc/apt/sources.list.d/mongodb.list
echo 'deb http://downloads-distro.mongodb.org/repo/debian-sysvinit dist 10gen' >> /etc/apt/sources.list.d/mongodb.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10

# fish shell
rm /etc/apt/sources.list.d/fish-shell.list
echo 'deb http://ppa.launchpad.net/fish-shell/release-2/ubuntu saucy main' >> /etc/apt/sources.list.d/fish-shell.list
echo 'deb-src http://ppa.launchpad.net/fish-shell/release-2/ubuntu saucy main' >> /etc/apt/sources.list.d/fish-shell.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-key 6DC33CA5 

# node.js
rm /etc/apt/sources.list.d/nodejs.list
echo "deb http://ppa.launchpad.net/chris-lea/node.js/ubuntu saucy main " >> /etc/apt/sources.list.d/nodejs.list
echo "deb-src http://ppa.launchpad.net/chris-lea/node.js/ubuntu saucy main" >> /etc/apt/sources.list.d/nodejs.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C7917B12

# git
rm /etc/apt/sources.list.d/git.list
echo "deb http://ppa.launchpad.net/git-core/ppa/ubuntu saucy main" >> /etc/apt/sources.list.d/git.list
echo "deb-src http://ppa.launchpad.net/git-core/ppa/ubuntu saucy main" >> /etc/apt/sources.list.d/git.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E1DF1F24 

#wireshark
rm /etc/apt/sources.list.d/wireshark.list
echo "deb http://ppa.launchpad.net/dreibh/ppa/ubuntu saucy main" >> /etc/apt/sources.list.d/wireshark.list
echo "deb-src http://ppa.launchpad.net/dreibh/ppa/ubuntu saucy main " >> /etc/apt/sources.list.d/wireshark.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 916C56E0  

#sublime 3
rm /etc/apt/sources.list.d/sublime.list
echo "deb http://ppa.launchpad.net/webupd8team/sublime-text-3/ubuntu saucy main " >> /etc/apt/sources.list.d/sublime.list
echo "deb-src http://ppa.launchpad.net/webupd8team/sublime-text-3/ubuntu saucy main " >> /etc/apt/sources.list.d/sublime.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886  