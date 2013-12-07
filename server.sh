#!/bin/sh
# Marcin Jasion

OS=$(lsb_release -si)

if [ $USER != 'root' ]; then
        echo "Sorry, you need to run this as root"
        exit
fi

apt-get install python-software-properties -y

if [ "Debian" = "$OS" ]
then
	wget https://raw.github.com/mjasion/linux-stuff/master/repo/debian-repo.sh -q -O - | sudo sh
else
	wget https://raw.github.com/mjasion/linux-stuff/master/repo/ubuntu-repo.sh -q -O - | sudo sh
fi

apt-get update
apt-get install ntp vim nmap postgresql-9.3 mariadb-server mongodb-10gen tcpdump oracle-jdk7-installer dnsutils fish postfix nginx-extras openvpn htop iotop bwm-ng git gitk subversion nodejs jenkins maven -y
apt-get purge nano 
apt-get purge openjdk*
