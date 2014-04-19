#!/bin/sh
# Marcin Jasion

CODE_NAME=`lsb_release -c -s`
wget https://raw.githubusercontent.com/mjasion/linux-stuff/master/etc/ubuntu.sources.list -q -O - > /etc/apt/sources.list
sed -i "s/saucy/$CODE_NAME/g" /etc/apt/sources.list

# oracle java
add-apt-repository ppa:webupd8team/java
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886

# mariadb
rm /etc/apt/sources.list.d/mariadb.list
echo "deb http://mariadb.cu.be//repo/10.0/ubuntu `lsb_release -s -c` main" >> /etc/apt/sources.list.d/mariadb.list
echo "deb-src http://mariadb.cu.be//repo/10.0/ubuntu `lsb_release -s -c` main" >> /etc/apt/sources.list.d/mariadb.list
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
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10

# fish shell
apt-add-repository ppa:fish-shell/release-2
apt-key adv --keyserver keyserver.ubuntu.com --recv-key 6DC33CA5 

# node.js
add-apt-repository ppa:chris-lea/node.js
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C7917B12

# git
add-apt-repository ppa:git-core/ppa
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E1DF1F24 

#wireshark
add-apt-repository ppa:dreibh/ppa
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 916C56E0  

#sublime 3
#rm /etc/apt/sources.list.d/sublime.list
#echo "deb http://ppa.launchpad.net/webupd8team/sublime-text-3/ubuntu saucy main " >> /etc/apt/sources.list.d/sublime.list
#echo "deb-src http://ppa.launchpad.net/webupd8team/sublime-text-3/ubuntu saucy main " >> /etc/apt/sources.list.d/sublime.list
#apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886  
