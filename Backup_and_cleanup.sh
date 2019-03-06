#!/bin/bash


REMOTEUSER=
REMOTEHOST=
REMOTEBACKUPDIR=
RETENTIONDAYS=


if [[ ! -e webbackup.log ]] ; then
	touch webbackup.log
fi

if [[ ! -e cleanup.log ]] ; then
	touch cleanup.log
fi


###BACKUP:
echo "Starting web backup                                                        $(date)" >> webbackup.log;
tar -cvf /home/$USER/"WEB_Backup$(date '+%F').tar" /var/www/html/;
rsync --log-file=webbackup.log /home/$USER/"WEB_Backup$(date '+%F').tar" $REMOTEUSER@$REMOTEHOST:$REMOTEBACKUPDIR;
echo "Web Back up successful                                                     $(date)" >> webbackup.log;
echo "----------------------------------------------------------------------------------" >> webbackup.log;

###CLEANUP:
echo "Starting Cleanup of files older than $RETENTIONDAYS days                                                         $(date)" >> cleanup.log;
echo "Removing the following files(if empty no files removed):                                                                " >> cleanup.log;
echo `find /home/$USER/ -name "WEB_*" -mtime +"$RETENTIONDAYS" -exec ls {} \; | sort -n`                                        >> cleanup.log;
find /home/$USER/ -name "WEB_*" -mtime +"$RETENTIONDAYS" -exec rm -rf {} \;
echo "Cleanup finished                                                                                                 $(date)" >> cleanup.log;
echo "------------------------------------------------------------------------------------------------------------------------" >> cleanup.log;
