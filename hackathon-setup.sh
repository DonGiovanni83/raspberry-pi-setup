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
sudo echo "export LC_ALL=C" >> .bashrc
sudo echo "alias ll='ls -la'" >> .bashrc
source ~/.bashrc
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade
sudo apt-get install vim git -y
git clone https://github.com/DonGiovanni83/raspberry-pi-setup.git

#PiCar-S setup
git clone --recursive https://github.com/sunfounder/SunFounder_PiCar-S.git
cd SunFounder_PiCar-S
sudo ./install_dependencies
sudo apt-get update
sudo apt-get install python-smbus -y
cd
git clone --recursive https://github.com/sunfounder/SunFounder_PiCar.git
cd SunFounder_PiCar
python setup.py install
sudo echo "dtparam=i2c_arm=on" >> sudo /boot/config.txt

#PiCar-V setup
git clone https://github.com/sunfounder/SunFounder_PiCar-V.git
cd SunFounder_PiCar-V
sudo ./install_dependencies
cd

./raspberry-pi-setup/WifiSetup.main

touch READY


#//hackathon-setup .sh 

