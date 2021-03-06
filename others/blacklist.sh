#!/bin/bash

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

BLOCKDB="block.txt"
WORKDIR="/tmp"
pwd=$(pwd)
cd $WORKDIR
#List of ips to block
rm $BLOCKDB
ipset create blackips iphash -quiet
## Obtain List of badguys from openbl.org
wget -q -O- http://www.openbl.org/lists/base.txt | grep -Ev "^#" > $BLOCKDB
wget -q -O- http://www.ciarmy.com/list/ci-badguys.txt | grep -Ev "^#" >> $BLOCKDB
wget -q -O- http://feeds.dshield.org/top10-2.txt | grep -E "^[1-9]" | cut -f1 >> $BLOCKDB
wget -q -O- http://feeds.dshield.org/block.txt | grep -E "^[1-9]" | cut -f1,3 | sed "s/\t/\//g" >> $BLOCKDB
wget -q -O- http://www.spamhaus.org/drop/drop.lasso | grep -E "^[1-9]"  | cut -d" " -f1 >> $BLOCKDB

if [ -f $BLOCKDB ]; then
    IPList=$(grep -E '^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$' $BLOCKDB |sort -u)
    for i in $IPList; do
        #echo "ipset add blackips $i -quiet"
        ipset add blackips $i -quiet
    done
fi

#List of networks to block
ipset create blacknets nethash -quiet
if [ -f $BLOCKDB ]; then
    IPList=$(grep -E '^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/[0-9]{1,2}$' $BLOCKDB |sort -u)
    for i in $IPList; do
        #echo "ipset add blacknets $i"
        ipset add blacknets $i -quiet
    done
fi

#Drop blacklisted ips
iptables -A INPUT -m set --match-set blackips src -j DROP
iptables -A INPUT -m set --match-set blacknets src -j DROP
cd $pwd
