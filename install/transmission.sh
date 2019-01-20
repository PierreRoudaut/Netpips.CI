#!/bin/bash
#
# - Installs transmission-daemon
# - Sets transmission to run as netpips
#
#############

set -e

apt-get install -y transmission-cli
apt-get install -y transmission-daemon
apt-get install -y transmission-common

user='netpips'
service 'transmission-daemon' stop
sed -i s/debian-transmission/$user/g /etc/init.d/transmission-daemon
sed -i s/debian-transmission/$user/g /etc/init/transmission-daemon.conf
sed -i s/debian-transmission/$user/g /lib/systemd/system/transmission-daemon.service
chown -R "$user:$user" /var/lib/transmission-daemon
chown -R "$user:$user" /etc/transmission-daemon
systemctl daemon-reload ; sudo service 'transmission-daemon' start ; sleep 1

echo 'Transsmission => OK'
