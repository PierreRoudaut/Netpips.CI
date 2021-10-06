#!/bin/bash
#
# - Installs nginx
#
#############################

set -eu

script_name=`basename "$0"`
if [ "$#" -ne 2 ]; then
    echo "./$script_name [DOMAIN] [NGINX_CONF_TMPL_PATH]"
    exit 1
fi

DOMAIN=$1
NGINX_CONF_TMPL_PATH=$2

if [[ ! -f '/var/netpips/client/index.html' ]]; then
    sudo mkdir -p /var/netpips/client
    sudo echo 'hello world' > /var/netpips/client/index.html
    chown -R netpips:netpips /var/netpips/client
fi


sudo apt-get install -y nginx
sudo service nginx stop || true
sudo rm -f /etc/nginx/sites-available/*
sudo rm -f /etc/nginx/sites-enabled/*

cat $NGINX_CONF_TMPL_PATH | sudo sed s/{{domain}}/$DOMAIN/g > /etc/nginx/sites-available/netpips.conf
sudo ln -s /etc/nginx/sites-available/netpips.conf /etc/nginx/sites-enabled/netpips.conf

sudo service nginx start
sudo service nginx status
