#Quick script to help in determining which kernels to remove when /boot gets full on Ubuntu 12-16 based distros. 
#This script has been updated to remove kernels and has been tested on Ubuntu 12-18 based distros. 
#There is an option to list out kernels to manually remove instead of the script automatically removing them. 
#To do so comment line 21 and uncomment line 20.


#!/bin/bash
Current=`uname -r`
Installed=`ls /boot  | grep -F  vmlinuz | grep -Fv $Current | sed  's/^........//'`

echo "Current Kernel = $Current"
echo "These kernels can be removed if not in use:"
echo "$Installed"





while true; do
    read -p "Do you wish to remove these kernels" yn
    case $yn in
        [Yy]* ) echo "removing kernels not in use..."; 
for i in ${Installed[@]}; 
do
##If you just want to list the kernels to remove, uncomment below line and comment out apt-get remove line
##echo "Packages you need to remove via apt-get remove:"; dpkg -l | grep $i  | awk '{print$2}'
apt-get remove -y  $(dpkg -l | grep $i  | awk '{print$2}')
done;
exit;;
        [Nn]* ) echo "Exiting...."; exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
