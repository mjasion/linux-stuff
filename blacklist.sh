#!/bin/bash

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

ipset create blackips iphash -quiet
ipset create blacknets nethash -quiet

for ip in `ipset list blackips | grep -E "^[1-9]"`; do
  ipset del blackips $ip -q
done

for ip in `ipset list blacknets |grep -E "^[1-9]"`; do
  ipset del blacknets $ip -q
done

if [ -z "`iptables-save | grep blacknets`" ]; then
  iptables -I INPUT -m set --match-set blacknets src -j DROP
fi
if [ -z "`iptables-save | grep blackips`" ]; then
  iptables -I INPUT -m set --match-set blackips src -j DROP
fi

BLOCKDB="block.txt"
WORKDIR="/tmp"
pwd=$(pwd)
cd $WORKDIR
#List of ips to block
rm $BLOCKDB

## Obtain List of badguys from openbl.org
wget -q -O- http://www.openbl.org/lists/base.txt | grep -Ev "^#" > $BLOCKDB
wget -q -O- http://lists.blocklist.de/lists/all.txt | grep -E "^[1-9]" >> $BLOCKDB
wget -q -O- http://www.ciarmy.com/list/ci-badguys.txt | grep -Ev "^#" >> $BLOCKDB
wget -q -O- http://feeds.dshield.org/top10-2.txt | grep -E "^[1-9]" | cut -f1 >> $BLOCKDB
wget -q -O- http://feeds.dshield.org/block.txt | grep -E "^[1-9]" | cut -f1,3 | sed "s/\t/\//g" >> $BLOCKDB
wget -q -O- http://www.spamhaus.org/drop/drop.lasso | grep -E "^[1-9]"  | cut -d" " -f1 >> $BLOCKDB

if [ -f $BLOCKDB ]; then
    IPList=$(grep -E '^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$' $BLOCKDB |sort -u)
    for i in $IPList; do
        ipset add blackips $i -quiet
    done
fi

#List of networks to block
if [ -f $BLOCKDB ]; then
    IPList=$(grep -E '^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/[0-9]{1,2}$' $BLOCKDB |sort -u)
    for i in $IPList; do
        ipset add blacknets $i -quiet
    done
fi

cd $pwd

