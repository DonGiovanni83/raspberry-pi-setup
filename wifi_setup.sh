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
    echo "${all_essids[@]}"
    createmenu "${all_essids[@]}"
    echo $ESSID
}

#set password
function set_password {
    echo set_password
}

function connect_to_wifi {
    echo connect_to_wifi
}


# $1: array with options $2: Variable to store selection to
function createmenu {
    echo "Select an ESSID"
    select option; do
        if [ "$REPLY" -eq "$#" ];
        then
            echo "Your selection $option"
            ESSID=$option
            break;
        elif [ 1 -le "$REPLY" ] && [ "$REPLY" -le $(($#-1)) ];
        then
            echo "2Your selection $option"
            ESSID=$option
            break;
        else
            echo "Incorrect Input: Select a number 1-$#"
        fi
    done
}


#main excecution 
set_essid

#//wifi_setup .sh 

