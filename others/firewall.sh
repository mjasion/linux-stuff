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

# adresy IP z dostępem do SSH, podajemy oddzielone spacjami
ADM="194.29.146.3 81.210.53.0/24"

# odblokowane porty INPUT
# podawac po przecinku np. "21,22,123"
I_TCP="80,54322,123,22,9987,30033,10011,443,8000"
I_UDP="80,54322,123,9987,30033,10011,443"

# Porty wychodzace z serwera OUTPUT
O_TCP=""
O_UDP=""

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
iptables -A OUTPUT -o lo -j ACCEPT

# akceptujemy polaczenia zainicjowane przez serwer
iptables -A INPUT -m state --state INVALID -j LOG --log-prefix "DROP_INVALID: " --log-ip-options --log-tcp-options
iptables -A INPUT -m state --state INVALID -j DROP
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

#iptables -A OUTPUT -m state --state INVALID -j LOG --log-prefix "DROP_INVALID: " --log-ip-options --log-tcp-options
iptables -A OUTPUT -m state --state INVALID -j DROP
iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Ping
iptables -A INPUT -p icmp --icmp-type echo-request -j LOG --log-prefix "Ping: " --log-ip-options --log-tcp-options
iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT
iptables -A OUTPUT -p icmp --icmp-type echo-request -j ACCEPT

if [ -n "$ADM" ] ; then
for IP in $ADM ; do
iptables -A INPUT -s $IP -p tcp --dport 22 --syn -m state --state NEW -j ACCEPT
done
fi
