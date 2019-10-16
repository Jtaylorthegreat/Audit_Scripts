#!/bin/bash
#mass get over ssh
#add ips to "iplest" with each ip on it's own line
if [-z "$1" ]; then
  echo "Usage: ./mass_get.sh FILETOGET";
  else
    cat iplist | while read ips 
  do
	  scp  USERNAME@$ips:/home/USERNAME/$1  . ; done
fi
	
