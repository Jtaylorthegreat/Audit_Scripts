## nwi.sh network info script
## Created by Justin Taylor this script is a work in progress that will assist with basic service port enumeration
## this script creates info text files in sequence of commands, each command is based on a previous command's text output
## Text output files and dependencies:
## 1-ips.txt - list of active ips on network that are responding to pings *no dependency*
## 2-openports.txt - list of open ports of active ips *depends 1-ips.txt*
## 3-webservers.txt - list of suspected webservers (servers responding on tcp ports 80 & 443) *depends 2-openports.txt*
## 4-webserverscans.txt - version scan of suspected webserver IPs listed in 3-webservers.txt *depends 3-webservers.txt*

#!/bin/bash
if [ -z "$1" ]; then
  echo "Usage: ./nwi.sh [network]";
  echo "Example: ./nwi.sh 10.0.0";
else
  for ip in `seq 1 254`; do
    ping -c 1 $1.$ip | grep "64 bytes" | cut -d " " -f 4 | sed 's/.$//' >> 1-ips.txt 2>&1 &
  done;
nmap -nvv -Pn -sS  --stats-every 3m --max-retries 1 --max-scan-delay 20 --defeat-rst-ratelimit -T4 -p1-65535  -iL 1-ips.txt >> 2-openports.txt;
grep -E '80|443' 2-openports.txt | awk '{print$6}' | sort | uniq -d > 3-webservers.txt &&
grep -E '137|138|139|1433|1434|3306|3050|5432|3351|1583' 2-openports.txt | awk '{print$6}' | sort  > 4-databaseservers.txt &&
nmap -nvv -Pn- -sSV -p 80,443 --version-intensity 9 -A -iL 3-webservers.txt -oN 4-webserverscans.txt &
wait
fi;
