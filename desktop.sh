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
apt-get install openssh-server ntp vim nmap tcpdump oracle-jdk7-installer dnsutils fish postfix openvpn htop iotop bwm-ng git gitk gitg subversion nodejs maven curl whois wireshark sublime-text-installer -y --no-install-recommends
apt-get install fonts-cantarell lmodern ttf-aenigma ttf-georgewilliams ttf-bitstream-vera ttf-sjfonts ttf-tuffy tv-fonts ubuntustudio-font-meta ttf-sil-gentium fonts-dustin ttf-georgewilliams ttf-sjfonts ttf-larabie-deco ttf-larabie-straight ttf-larabie-uncommon ttf-larabie-deco ttf-larabie-straight ttf-larabie-uncommon ttf-aenigma msttcorefonts -y

# set fish sell default shell
sed -i 's/\/bin\/sh/\/usr\/bin\/fish/g' /etc/passwd
sed -i 's/\/bin\/bash/\/usr\/bin\/fish/g' /etc/passwd

# changing ntp.conf
wget https://raw.github.com/mjasion/linux-stuff/master/repo/ubuntu-repo.sh -q -O /etc/ntp.conf 

apt-get purge nano -y
apt-get purge openjdk* -y
