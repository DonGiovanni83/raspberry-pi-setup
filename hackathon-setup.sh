#
#       Title: hackathon-setup .sh
# Author: Fabio Bertagna
# Date created:  Fri 28 Dec 2018 10:16:34 PM CET 
# Comment: Setup Raspberry Pi for SunFounder PiCar-S and PiCar-V

 

#!/bin/bash

wget -q --tries=10 --timeout=20 --spider http://google.com
if [[ $? -eq 0 ]]; then
        echo "Working internet connection confirmed"
else
        echo "Offline"
        exit 1
fi


if [ "$(ls | grep READY)" = "READY" ];
then
    exit 1
fi

sudo echo "LC_ALL=en_US.UTF-8" >> sudo /etc/environment
sudo echo "en_US.UTF-8 UTF-8" >> sudo /etc/locale.gen
sudo echo "LANG=en_US.UTF-8" > sudo /etc/locale.conf
sudo locale-gen en_US.UTF-8
sudo echo "export LC_ALL=C" >> sudo ~/.bashrc
sudo echo "alias ll='ls -la'" >> sudo ~/.bashrc
source ~/.bashrc
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade
sudo apt-get install vim git -y
git clone https://github.com/DonGiovanni83/raspberry-pi-setup.git

sudo apt-get install python-pip -y
pip install setuptools

echo "For which robot do you want to set up your Raspberry Pi?"
options=("PiCar-S" "PiCar-V" "Cancel")
select opt in "${options[@]}"
do
    case $opt in
        "PiCar-S")
            #PiCar-S setup
            echo "Setting things up for PiCar-S...."
            git clone --recursive https://github.com/sunfounder/SunFounder_PiCar-S.git
            cd SunFounder_PiCar-S
            sudo ./install_dependencies
            cd ~
            ;;
        "PiCar-V")
            #PiCar-V setup
            echo "Setting things up for PiCar-V...."
            git clone https://github.com/sunfounder/SunFounder_PiCar-V.git
            cd SunFounder_PiCar-V
            sudo ./install_dependencies
            cd ~
            ;;
        "Cancel")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

./raspberry-pi-setup/WifiSetup/main.sh

sudo touch READY


#//hackathon-setup .sh 

