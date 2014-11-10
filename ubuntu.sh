#!/bin/bash

if [ $USER != 'root' ]; then
        echo "Sorry, you need to run this as root"
        exit
fi

apt-get install python-software-properties -y

add-apt-repository ppa:webupd8team/java -y
add-apt-repository ppa:git-core/ppa -y
add-apt-repository ppa:libreoffice/libreoffice-4-3 -y
add-apt-repository ppa:chris-lea/node.js -y
add-apt-repository ppa:djcj/vlc-stable -y
add-apt-repository ppa:dreibh/ppa -y # wireshark

echo "deb http://repository.spotify.com stable non-free " > /etc/apt/sources.list.d/spotify.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 94558F59


apt-get update
apt-get install openssh-server indicator-cpufreq ntp dstat vim nmap tcpdump oracle-jdk7-installer oracle-java8-installer oracle-java8-set-default\
        dnsutils pidgin pidgin-indicator network-manager-openvpn fish vlc openvpn htop iotop bwm-ng git gitg subversion sshpass \
    nodejs maven curl whois wireshark -y --no-install-recommends

wget -q -O - http://get.docker.io/ubuntu/ | bash

apt-get purge nano -y
apt-get purge openjdk* -y

apt-get dist-upgrade -y
apt-get autoremove -y
apt-get clean


# set fish sell default shell
sed -i 's/\/bin\/sh/\/usr\/bin\/fish/g' /etc/passwd
sed -i 's/\/bin\/bash/\/usr\/bin\/fish/g' /etc/passwd