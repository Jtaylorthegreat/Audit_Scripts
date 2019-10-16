#!/bin/bash
#mass push over ssh
#add ips to "iplest" with each ip on it's own line
if [-z "$1" ]; then
  echo "Usage: ./mass_push.sh FILETOMOVE";
  else
    cat iplist | while read ips 
  do
	  scp $1 USERNAME@$ips:/home/USERNAME/; done
fi
	
