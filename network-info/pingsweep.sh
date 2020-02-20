#!/bin/bash
#Script was not originally written by me, this was taken from a random online OSCP Training course
if [ "$1" == "" ]
  then
    echo "Usage: ./pingsweep.sh [network]"
    echo "Example: ./pingsweep.sh 10.0.0"
  else
    for ip in `seq 1 254`; do
    ping -c 1 $1.$ip | grep "64 bytes" | cut -d " " -f 4 | sed 's/.$//' &
  done
fi
