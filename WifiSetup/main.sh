#
#       Title: wifi_setup .sh
# Author: Fabio Bertagna
# Date created:  Fri 28 Dec 2018 06:00:15 PM CET 
# Comment: prompt to setup wifi from terminal

 

#!/bin/bash

ESSID=""
PASSWD=""


#check if necessary tools are installed else install them or abort
function check_for_tools { 
    if ! [ -x "$(command -v wpasupplicant)" ];
    then
        echo 'Error: wpasupplicant is not installed.'
        echo "Do you want to install wpasupplicant?(y/n)"
        read answer
        if [ "${answer}" = "y" ];
        then
            sudo apt-get install wpasupplicant
        else
            exit 1;
        fi 
    fi
}

#scan for network and choose one
function set_essid {
    #get all network names
    all_essids="$(iwlist wlan0 scanning | grep ESSID | grep -o '".*"')" 
    echo "Select an ESSID"

    #Create whitespace safe array of ESSIDs
    OLD_IFS=${IFS}
    IFS=$'\n'
    MYARRAY=()
    for opt in ${all_essids[@]}
    do
        if [ "${opt}" !=  "" ];
        then
            MYARRAY+=("${opt}")
        fi
    done

    IFS=$'" "'

    select option in "${MYARRAY[@]}"; do
        if [ "$REPLY" -eq "${#MYARRAY[*]}" ];
        then
            echo "Your selection $option"
            ESSID=$option
            break;
        elif [ 1 -le "$REPLY" ] && [ "$REPLY" -le $((${#MYARRAY[*]}-1)) ];
        then
            echo "2Your selection $option"
            ESSID=$option
            break;
        else
            echo "Incorrect Input: Select a number 1-${#MYARRAY[*]}"
        fi
    done
    echo $ESSID
    #reset IFS
    IFS=${OLD_IFS}
}

#set password
function set_password {
    echo "Enter the passwor for $ESSID:"
    read -s PASSWD
}

function connect_to_wifi {
    #configure wlan0 on raspberry pi
    echo "auto lo

iface lo inet loopback
iface eth0 inet dhcp

allow-hotplug wlan0
auto wlan0


iface wlan0 inet dhcp
wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf" > sudo /etc/network/interfaces
    set_essid && set_password
    sudo echo "network={
    ssid=$ESSID
    psk="\"${PASSWD}\""
}" > /etc/wpa_supplicant.conf;
    sudo wpa_supplicant -B -i wlan0 -c /etc/wpa_supplicant.conf -D wext
    sudo dhclient wlan0
}

#main execution
check_for_tools
connect_to_wifi

#//wifi_setup .sh 

