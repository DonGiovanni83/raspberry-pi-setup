#
#       Title: setup_pi .sh
# Author: Fabio Bertagna
# Date created:  Fri 28 Dec 2018 04:03:36 PM CET 
# Comment: Used to install and setup all required tools for the raspberry pi

 

#!/bin/bash



cd

ESSIDS = iwconfig wlan0 | grep ESSID | awk -F: '{print $2}' | sed 's/\"//g';
PS3='Please enter your : '
options=("Option 1" "Option 2" "Option 3" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Option 1")
            echo "you chose choice 1"
            ;;
        "Option 2")
            echo "you chose choice 2"
            ;;
        "Option 3")
            echo "you chose choice $REPLY which is $opt"
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
echo "Enter essid of wirelessnetwork you wish to connect to:"
read WESSID;
echo "Enter its password";
read WPASSWORD
sudo apt-get install wpasupplicant;
sudo touch wpa_supplicant.conf
sudo echo "network={
    ssid=$WESSID
    psk=$WPASSWORD
}" >> /wpa_supplicant.conf;
sudo wpa_supplicant -B -i wlan0 -c /etc/wpa_supplicant.conf -D wext;
sudo dhclient wlan0;

#//setup_pi .sh 

