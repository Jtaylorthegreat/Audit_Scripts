#!/bin/bash
# script depends on smartmontools
# apt-get install smartmontools | yum install smartmontools
# Must run with elevated privileges
R="\e[0;49;31m"
W="\e[0;39m"
G="\e[1;32m"
B="\e[1;49;34m"
smartctl -t short /dev/sda;
smartctl -t short /dev/sdb;
clear
for i in {59..01}
        do
                echo "Please wait $i more seconds disk test is still running"
                sleep 1
                clear
        done

echo -e $R "---------------------------------------------------------------------------------------------------------------"    >>  /root/"Disk_test$(date '+%F').txt";
echo -e $G " /dev/sda                                                                                                      "    >>  /root/"Disk_test$(date '+%F').txt";
echo -e $R "---------------------------------------------------------------------------------------------------------------" $W >>  /root/"Disk_test$(date '+%F').txt";
smartctl -l selftest /dev/sda >> /root/"Disk_test$(date '+%F').txt";
echo -e $R "---------------------------------------------------------------------------------------------------------------"    >>  /root/"Disk_test$(date '+%F').txt";
echo -e $G " /dev/sdb                                                                                                      "    >>  /root/"Disk_test$(date '+%F').txt";
echo -e $R "---------------------------------------------------------------------------------------------------------------" $W >>  /root/"Disk_test$(date '+%F').txt";
smartctl -l selftest /dev/sdb >> /root/"Disk_test$(date '+%F').txt";
echo -e $R "---------------------------------------------------------------------------------------------------------------" $W >>  /root/"Disk_test$(date '+%F').txt";
echo "Disk Test complete please /root/Disk_test$(date '+%F').txt for more info"
