linux-stuff
===========
Scripts to automate installation on Debian/Ubuntu/Linux Mint and other stuff :)

## usage
Server:

```bash
wget https://raw.github.com/mjasion/linux-stuff/master/server.sh -q -O - | sudo sh
```

Desktop:
```bash
wget https://raw.github.com/mjasion/linux-stuff/master/desktop.sh -q -O - | sudo sh
```
http://www.webupd8.org/2014/02/get-unity-global-menu-hud-support-for.html

## packages
### desktop.sh
- fish - set also for all user as default
- ntp + config with servers localized in Warsaw
- vim 
- nmap 
- tcpdump 
- Oracle Java 7 
- dnsutils 
- postfix 
- openvpn 
- htop 
- iotop 
- bwm-ng 
- git 
- gitk
- gitg
- subversion 
- nodejs 
- maven
- wireshark
- Sublime Text
- fonts

### server.sh
- fish - set also for all user as default
- ntp + config with servers localized in Warsaw
- vim 
- nmap 
- postgresql-9.3 
- mariadb-server 
- mongodb-10gen 
- tcpdump 
- oracle-jdk7-installer 
- dnsutils 
- postfix 
- nginx-extras 
- openvpn 
- htop 
- iotop 
- bwm-ng 
- git 
- gitk
- subversion 
- nodejs 
- jenkins 
- maven

## config.fish


My configuration file for fishshell. GitPrompt configured with http://mariuszs.github.io/ settings :)

HINT: I have added this to file: `/usr/share/fish/config.fish`(ubuntu). 
If you will add this to `.config/fish/config.fish`, then other users will use default configuration

#####Example
![](http://i.imgur.com/WWASu2r.png)
