#!/bin/bash
#
# - Installs transmission-daemon
# - Sets transmission to run as netpips
#
#########################################

set -e

sudo apt-get install -y transmission-cli
sudo apt-get install -y transmission-daemon
sudo apt-get install -y transmission-common

user='netpips'
sudo service 'transmission-daemon' stop
sudo sed -i s/debian-transmission/$user/g /etc/init.d/transmission-daemon
sudo sed -i s/debian-transmission/$user/g /etc/init/transmission-daemon.conf
sudo sed -i s/debian-transmission/$user/g /lib/systemd/system/transmission-daemon.service
sudo chown -R "$user:$user" /var/lib/transmission-daemon
sudo chown -R "$user:$user" /etc/transmission-daemon
sudo systemctl daemon-reload ; sudo service 'transmission-daemon' start ; sleep 1

echo 'Transsmission => OK'
