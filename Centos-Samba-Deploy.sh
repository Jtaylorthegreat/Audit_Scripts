#!/bin/bash

#|-----------------------------|#
#|Centos SAMBA Share Deployment|#
#|-----------------------------|#

read -p 'Enter desired workgroup: ' DESWORKGROUP
read -p 'Enter desired Samba Share Name: ' DESSAMBANAME
read -p 'Enter Listening IP address: ' LISIP
read -p 'Enter desired samba directory name (to be created): ' SAMBADIR
read -p 'Enter Samba User: ' SAMBAUSER


yum install -y samba samba-client
setsebool -P samba_export_all_ro=1 samba_export_all_rw=1 samba_share_nfs=1
mkdir /$SAMBADIR
chown $SAMBAUSER:$SAMABAUSER -R /$SAMBADIR
semanage fcontext -at samba_share_t "/$SAMBADIR(/.*)?"
restorecon /$SAMBADIR

firewall-cmd --permanent --add-service=samba
firewall-cmd --reload

mv /etc/samba/smb.conf /etc/samba/smb.conf.original

echo "[global]" > /etc/samba/smb.conf
echo "workgroup           =  $DESWORKGROUP" >> /etc/samba/smb.conf
echo "server string       =  $LISIP" >> /etc/samba/smb.conf
echo "hosts allow         =  ALL" >> /etc/samba/smb.conf
echo "interfaces          =  lo eth0" >> /etc/samba/smb.conf
echo "passdb backend      = smbpasswd" >> /etc/samba/smb.conf
echo "security            = user" >> /etc/samba/smb.conf
echo "log file            = /var/log/samba%m.log" >> /etc/samba/smb.conf
echo "max log size        = 5000" >> /etc/samba/smb.conf
echo "[$DESSAMBANAME]" >> /etc/samba/smb.conf
echo "comment             = /$SAMBADIR" >> /etc/samba/smb.conf
echo "browsable           = yes" >> /etc/samba/smb.conf
echo "path                = /$SAMBADIR" >> /etc/samba/smb.conf
echo "public              = yes" >> /etc/samba/smb.conf
echo "valid users         = $SAMBAUSER" >> /etc/samba/smb.conf
echo "write list          = $SAMABAUSER" >> /etc/samba/smb.conf
echo "writable            = yes" >> /etc/samba/smb.conf

systemctl enable smb; 

smbpasswd -a $SAMBAUSER

systemctl start smb

echo "Testing local samba connection"
smbclient -L //localhost -U $SAMBAUSER
