#!/bin/bash
#
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
sudo killall nginx 2> /dev/null || true
sudo certbot --nginx --domains $DOMAIN --non-interactive --redirect --agree-tos -m $CERTBOT_CONTACT_EMAIL
sudo nginx -s reload || true
sudo systemctl daemon-reload
sudo service nginx start
sudo service nginx status
