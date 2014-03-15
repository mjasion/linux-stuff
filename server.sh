#!/bin/sh
# Marcin Jasion

OS=$(lsb_release -si)

if [ $USER != 'root' ]; then
        echo "Sorry, you need to run this as root"
        exit
fi
echo "Setting time zone"
dpkg-reconfigure tzdata

echo "Setting locales"
dpkg-reconfigure locales

apt-get install python-software-properties -y

if [ "Debian" = "$OS" ]
then
	echo "Adding debian repositories"
	wget https://raw.github.com/mjasion/linux-stuff/master/repo/debian-repo.sh -q -O - | sh
else
	echo "Adding debian repositories"
	wget https://raw.github.com/mjasion/linux-stuff/master/repo/ubuntu-repo.sh -q -O - | sh
fi

echo ""
echo "Update & Instal"
apt-get update
apt-get purge nano -y 
apt-get dist-upgrade -y
#apt-get install openssh-server ntp vim nmap postgresql-9.3 mongodb-10gen tcpdump oracle-jdk7-installer dnsutils fish curl whois postfix nginx-extras openvpn htop iotop bwm-ng git gitk subversion nodejs jenkins maven -y --no-install-recommends -t jessie
apt-get install openssh-server ntp vim nmap tcpdump dnsutils fish curl whois postfix nginx-extras openvpn htop iotop bwm-ng git gitk subversion nodejs maven -y --no-install-recommends -t jessie

# set fish sell default shell
sed -i 's/\/bin\/sh/\/usr\/bin\/fish/g' /etc/passwd
sed -i 's/\/bin\/bash/\/usr\/bin\/fish/g' /etc/passwd

# changing ntp.conf
wget https://raw.github.com/mjasion/linux-stuff/master/etc/ntp.conf -q -O /etc/ntp.conf 

apt-get autoremove
apt-get purge openjdk* -y

echo ""
echo ""
echo "Now you can install f.e:"
echo "- postgresql-9.3"
echo "- mongodb-10gen"
echo "- oracle-jdk7-installer / oracle-java7-installer"
echo "- oracle-java8-installer"
echo "- jenkins"