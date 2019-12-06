#!/bin/bash
#script depends on hddtemp being installed on remote host
#script is currently set to only grab temps from sda & sdb but can easily modified

REMOTEUSER=
REMOTESERVERIP=
OUTPUTFILE=




DISK1TEMP=`ssh -t $REMOTEUSER@$REMOTESERVERIP 'hddtemp /dev/sda | awk '\''{print $4}'\'' | sed 's/..$//''` 
DISK2TEMP=`ssh -t $REMOTEUSER@$REMOTESERVERIP 'hddtemp /dev/sdb | awk '\''{print $4}'\'' | sed 's/..$//''` 

echo "$DISK1TEMP $DISK2TEMP" >> $OUTPUTFILE
perl -p -i -e "s/\r//g" $OUTPUTFILE
