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
	wget https://raw.github.com/mjasion/linux-stuff/master/repo/debian-repo.sh -q -O - | sh
else
	wget https://raw.github.com/mjasion/linux-stuff/master/repo/ubuntu-repo.sh -q -O - | sh
fi

apt-get update
apt-get install openssh-server ntp vim nmap tcpdump oracle-jdk7-installer dnsutils fish postfix openvpn htop iotop bwm-ng git gitk subversion nodejs maven wireshark sublime-text-installer -y --no-install-recommends

# set fish sell default shell
sed -i 's/\/bin\/sh/\/usr\/bin\/fish/g' /etc/passwd
sed -i 's/\/bin\/bash/\/usr\/bin\/fish/g' /etc/passwd

apt-get purge nano -y
apt-get purge openjdk* -y
