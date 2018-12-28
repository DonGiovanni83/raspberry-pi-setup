#
#       Title: startup-script .sh
# Author: Fabio Bertagna
# Date created:  Fri 28 Dec 2018 11:31:39 PM CET 
# Comment: 

 

#!/bin/bash

cd
wget -q --tries=10 --timeout=20 --spider http://google.com
if [[ $? -eq 0 ]]; then
        echo "Online"
else
        echo "Offline"
        exit 1
fi

if [ -f ./hackathon-setup.sh ]; then
   exit 1
else
    wget https://raw.githubusercontent.com/DonGiovanni83/raspberry-pi-setup/master/hackathon-setup.sh
    sudo chmod +x hackathon-setup.sh
    sudo ./hackathon-setup.sh
fi



#//startup-script .sh 

