#!/bin/bash
# script depends on smartmontools
# apt-get install smartmontools | yum install smartmontools
R="\e[0;49;31m"
W="\e[0;39m"
G="\e[1;32m"
smartctl -t short /dev/sda;
smartctl -t short /dev/sdb;
sleep 5;
echo -e $R "---------------------------------------------------------------------------------------------------------------" >>  /home/$USER/"Disk_test$(date '+%F').txt";
echo -e $G " /dev/sda                                                                                                      " >>  /home/$USER/"Disk_test$(date '+%F').txt";
echo -e $R "---------------------------------------------------------------------------------------------------------------" $W >>  /home/$USER/"Disk_test$(date '+%F').txt";
smartctl -l selftest /dev/sda >> /home/$USER/"Disk_test$(date '+%F').txt";
echo -e $R "---------------------------------------------------------------------------------------------------------------" >>  /home/$USER/"Disk_test$(date '+%F').txt";
echo -e $G " /dev/sdb                                                                                                      " >>  /home/$USER/"Disk_test$(date '+%F').txt";
echo -e $R "---------------------------------------------------------------------------------------------------------------" $W >>  /home/$USER/"Disk_test$(date '+%F').txt";
smartctl -l selftest /dev/sdb >> /home/$USER/"Disk_test$(date '+%F').txt";
echo -e $R "---------------------------------------------------------------------------------------------------------------" $W >>  /home/$USER/"Disk_test$(date '+%F').txt";
