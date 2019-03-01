#!/bin/bash

#Kernel Version
KERNEL=`uname -a`
#OS Version
OSVERSION=`cat /etc/*-release`
#Network Interface info
INTERFACE=`ip a`
#Open Listening Ports
PORTS=`netstat -plnt`
#ntp configuration:
NTP=`chronyc sources -v`
#last update
UPDATE=`tail -n 1  /var/log/yum.log | awk '{print $1,$2,$3}'`
#Antivirus running
ANTIVIRUS=`service ds_agent status | awk '{print $4,$5}'`
#Enabled Services
SERVICES=`systemctl list-unit-files | grep enabled`
#filesystems
FILESYSTEM=`lsblk -f`
#directories
DIRECTORIES=`du -x -BG / | sort -rn | head -n 20`

echo "
==================================================
- Kernel Version.....: $KERNEL
==================================================
- OS Version.........: $OSVERSION
==================================================
- Network Interfaces.: $INTERFACE
==================================================
- Open Ports.........: $PORTS
==================================================
- NTP Settings.......: $NTP
==================================================
- Last Update Applied........: $UPDATE
==================================================
- AntiVirus Currently........: $ANTIVIRUS
==================================================
- Current Running Services...: $SERVICES
==================================================
- Current Mounted Filesystems: $FILESYSTEM
==================================================
- Top 20 Largest Directories.: 
$DIRECTORIES
==================================================
" >> /home/$USER/"System_Audit$(date '+%F').txt"
