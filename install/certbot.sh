#!/bin/bash
#
# - Installs certbot
# - Sets up https on domain
#
#############################

set -eu


script_name=`basename "$0"`
if [ "$#" -ne 2 ]; then
    echo "./$script_name [DOMAIN] [CERTBOT_CONTACT_EMAIL]"
    exit 1
fi

DOMAIN=$1
CERTBOT_CONTACT_EMAIL=$2


sudo service nginx stop || true
sudo apt-get update -y
sudo apt-get install software-properties-common -y
sudo add-apt-repository universe -y
sudo add-apt-repository ppa:certbot/certbot -y
sudo apt-get update -y
sudo apt-get install python-certbot-nginx -y

sudo certbot --nginx --domains $DOMAIN --non-interactive --redirect --agree-tos -m $CERTBOT_CONTACT_EMAIL
sudo nginx -s reload || true
sudo systemctl daemon-reload
sudo service nginx status
