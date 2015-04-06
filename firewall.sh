### BEGIN INIT INFO
# Provides: firewall
# Required-Start: $remote_fs $syslog
# Required-Stop: $remote_fs $syslog
# Default-Start: 2 3 4 5
# Default-Stop: 0 1 6
# Short-Description: Start firewall daemon at boot time
# Description: Enable service provided by daemon.
### END INIT INFO

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

iptables-save > "/etc/iptables_`date +%d-%m-%y_%H:%M:%S`.old"

# interface
LAN="eth0"
DOCKER_SUBNET="172.17.42.1/16"

# adresy IP z dostępem do SSH, podajemy oddzielone spacjami
ADM=""

# odblokowane porty INPUT
# podawac po przecinku np. "21,22,123"
PORTS="80,8080,22"

# odblokowane porty DOCKER na które dopuszczalne jest przekierowanie
# podawac po przecinku np. "21,22,123"
DOCKER_PORTS="80,8080"

clear_iptables() {
	iptables -F
	iptables -X
}

setup_default_docker_rules() {
	iptables -N DOCKER
	iptables -A FORWARD -o docker0 -j DOCKER
	iptables -A FORWARD -o docker0 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
	iptables -A FORWARD -i docker0 ! -o docker0 -j ACCEPT
}

#DOCKER_FILTER_RULES="/tmp/docker_filter_`date +%s`"
#DOCKER_NAT_RULES="/tmp/docker_nat_`date +%s`"
#backupDockerRules() {
#    iptables-save -t filter | \
#	egrep \(DOCKER\|docker0\) | \
#	egrep -v \(:DOCKER\) | \
#	while IFS= read -r LINE; do echo "iptables $LINE" >> $DOCKER_FILTER_RULES; done
#	iptables-save -t nat > $DOCKER_NAT_RULES
#}
#restoreDockerRules() {
#	iptables-restore < $DOCKER_NAT_RULES
#	iptables -N DOCKER
#}

case "$1" in
start|restart)

echo "Czyszczenie firewall'a..."
#czyszczenie regul
clear_iptables

echo "Start firewall'a..."
#Odrzucamy domyslnie wszystie pakiety przychodzace
iptables -P INPUT DROP 
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# pozwalamy na ruch na interfejsie lokalnym
iptables -A INPUT -i lo -j ACCEPT
#iptables -A OUTPUT -o lo -j ACCEPT

iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
#iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

iptables -A OUTPUT -m state --state INVALID -j DROP
iptables -A INPUT -m state --state INVALID -j LOG --log-prefix "DROP_INVALID: " --log-ip-options --log-tcp-options
iptables -A INPUT -m state --state INVALID -j DROP

#Drop blacklisted ips - look at blacklist.sh
ipset create blackips iphash -quiet
ipset create blacknets nethash -quiet
iptables -A INPUT -m set --match-set blackips src -j DROP
iptables -A INPUT -m set --match-set blacknets src -j DROP

# odblokwanie portow TCP i UDP
if [ -n "$PORTS" ] ; then
	iptables -A INPUT -m multiport -p tcp --dports $PORTS --syn -m state --state NEW -j ACCEPT
	iptables -A INPUT -m multiport -p udp --dports $PORTS -m state --state NEW -j ACCEPT
fi

if [ -n "$ADM" ] ; then
        for IP in $ADM ; do
        iptables -A INPUT -s $IP -i $LAN -j ACCEPT
        done
fi

#DOCKER
setup_default_docker_rules
if [ -n "$DOCKER_PORTS" ] ; then
	iptables -A DOCKER ! -i docker0 -o docker0 -d $DOCKER_SUBNET -m multiport -p tcp --dport $DOCKER_PORTS -j ACCEPT
	iptables -A DOCKER ! -i docker0 -o docker0 -d $DOCKER_SUBNET -m multiport -p udp --dport $DOCKER_PORTS -j ACCEPT
	iptables -A DOCKER ! -i docker0 -o docker0 -j DROP
fi

#traceroute
iptables -A INPUT -i $LAN -p udp -m udp --dport 33434:33523 -m state --state NEW -j REJECT --reject-with icmp-port-unreachable

# Ping
iptables -A INPUT -p icmp --icmp-type echo-request -j LOG --log-prefix "Ping: " --log-ip-options --log-tcp-options
#iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT
iptables -A INPUT -p icmp --icmp-type echo-request -j REJECT --reject-with icmp-port-unreachable
#iptables -A OUTPUT -p icmp --icmp-type echo-request -j ACCEPT

# logowanie pakietow odrzuconych /var/log/messages
iptables -A INPUT ! -i lo -j LOG --log-prefix "DROP_INPUT: " --log-ip-options --log-tcp-options
;;

clear)
echo "Czyszczenie firewall'a..., UWAGA! wszystko na ACCEPT!"
clear_iptables
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
setup_default_docker_rules
iptables -A DOCKER ! -i docker0 -o docker0 -d $DOCKER_SUBNET -j ACCEPT
;;

*)
N=/etc/init.d/$NAME
echo "Usage: $N {start|restart|clear}" >&2
exit 1
;;

esac
exit 0



