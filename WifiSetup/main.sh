#
#       Title: wifi_setup .sh
# Author: Fabio Bertagna
# Date created:  Fri 28 Dec 2018 06:00:15 PM CET 
# Comment: prompt to setup wifi from terminal

 

#!/bin/bash

ESSID=""
PASSWD=""


#install needed software
function install_tools {
    sudo apt-get install wpasupplicant;
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
    echo "$PASSWD"
}

function connect_to_wifi {
    echo connect_to_wifi
}


#main excecution 
set_essid && set_password

#//wifi_setup .sh 

