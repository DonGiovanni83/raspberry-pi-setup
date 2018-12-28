#
#       Title: hackathon-setup .sh
# Author: Fabio Bertagna
# Date created:  Fri 28 Dec 2018 10:16:34 PM CET 
# Comment: setup after first raspberry pi boot

 

#!/bin/bash


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



#//hackathon-setup .sh 

