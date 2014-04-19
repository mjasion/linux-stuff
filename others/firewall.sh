### BEGIN INIT INFO
# Provides: firewall
# Required-Start: $remote_fs $syslog
# Required-Stop: $remote_fs $syslog
# Default-Start: 2 3 4 5
# Default-Stop: 0 1 6
# Short-Description: Start firewall daemon at boot time
# Description: Enable service provided by daemon.
### END INIT INFO

FAIL2BAN="/etc/init.d/fail2ban"
# interface
LAN="eth0"
TUN="tun0"

# adresy IP z dostępem do SSH, podajemy oddzielone spacjami
ADM=""


# odblokowane porty INPUT
# podawac po przecinku np. "21,22,123"
I_TCP="80,54322,123,9987,30033,10011,443,51194,8000"
I_UDP="80,54322,123,9987,30033,10011,443,51194"

case "$1" in
start|restart)

echo "Czyszczenie firewall'a..."
#czyszczenie regul
iptables -F
iptables -X

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

# odblokwanie portow TCP i UDP
if [ -n "$I_TCP" ] ; then
	iptables -A INPUT -m multiport -p tcp --dports $I_TCP --syn -m state --state NEW -j ACCEPT
fi

if [ -n "$I_UDP" ] ; then
	iptables -A INPUT -m multiport -p udp --dports $I_UDP -m state --state NEW -j ACCEPT
fi

if [ -n "$ADM" ] ; then
        for IP in $ADM ; do
        iptables -A INPUT -s $IP -i $LAN -j ACCEPT
        done
fi

#openvpn
#forwardowanie pakietow
iptables -A INPUT -i $TUN -j ACCEPT
iptables -A FORWARD -o $TUN -j ACCEPT
#routing dla adresu ip klienta
iptables -t nat -A POSTROUTING -s 10.8.0.2/255.255.0.0 -j MASQUERADE
iptables -A FORWARD -s 10.8.0.2/255.255.0.0 -j ACCEPT

#traceroute
iptables -A INPUT -i $LAN -p udp -m udp --dport 33434:33523 -m state --state NEW -j REJECT --reject-with icmp-port-unreachable

# Ping
iptables -A INPUT -p icmp --icmp-type echo-request -j LOG --log-prefix "Ping: " --log-ip-options --log-tcp-options
iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT
#iptables -A OUTPUT -p icmp --icmp-type echo-request -j ACCEPT

# logowanie pakietow odrzuconych /var/log/messages
iptables -A INPUT ! -i lo -j LOG --log-prefix "DROP_INPUT: " --log-ip-options --log-tcp-options
;;

clear)
echo "Czyszczenie firewall'a..., UWAGA! wszystko na ACCEPT!"
iptables -F
iptables -X
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
;;

*)
N=/etc/init.d/$NAME
echo "Usage: $N {start|stop}" >&2
exit 1
;;

esac

$FAIL2BAN restart

exit 0
