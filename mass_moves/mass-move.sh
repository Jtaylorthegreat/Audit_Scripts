#!/bin/bash

# Cleaner way to push or get files from multiple servers using a single user and one time password entry
# script depends on expect being installed and a list of ips named "iplest" with each ip on it's own line
# Examples:
#./mass-move.sh MYUSER MYPASSWORD get remotefile.txt
#./mass-move.sh MYUSER MYPASSWORD push localfile.txt
if [ -z "$4" ]; then 
	echo "Usage: ./mass-move USER PASSWORD ACTION[get/push] FILE"
	exit 2
else
	if [ $3 == "push" ]; then
		user=$1
		passwd=$2
		action=$3
		file=$4
		for ip in `cat iplist`;	do
			/usr/bin/expect -c ' spawn scp -P2242 '$file' '$user'@'$ip':/home/'$user'/
			expect "assword"
			send "'$passwd'\r"
			"interact"'; done

	elif [ $3 == "get" ]; then
		user=$1
		passwd=$2
		action=$3
		file=$4
		for ip in `cat iplist`;	do
			/usr/bin/expect -c ' spawn scp -P2242  '$user'@'$ip':/home/'$user'/'$file' '$file'_'$ip'
			expect "assword"
			send "'$passwd'\r"
			"interact"'; done
	else
		echo "Usage: ./mass-move USER PASSWORD get/push FILE"
		echo "Example: ./mass-move bob pass1234 push myfile.txt"
		exit 3
	fi
fi
