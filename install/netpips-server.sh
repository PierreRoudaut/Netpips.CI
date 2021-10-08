#!/bin/bash
#
# - Installs netpips-server service
#
##################################

set -exu

user='netpips'


sudo systemctl disable netpips-server.service || true
sudo rm -f /etc/systemd/system/netpips-server.service
# sudo cat netpips-server.service.tmpl | sed s/{{user}}/$user/g  > /etc/systemd/system/netpips-server.service
sudo cp netpips-server.service /etc/systemd/system/netpips-server.service
sudo systemctl daemon-reload
sudo systemctl enable netpips-server.service
sudo service netpips-server start


