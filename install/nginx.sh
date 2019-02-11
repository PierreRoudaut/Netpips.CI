#!/bin/bash
#
# - Installs nginx
# - Sets up http routes for client and server
# - Installs certbot
# - Sets up https on domain
#
#############################

set -eu

conf='netpips.conf'
: "${DOMAIN:?DOMAIN not set}"
: "${CERTBOT_CONTACT_EMAIL:?CERTBOT_CONTACT_EMAIL not set}"

apt-get install -y nginx
service nginx stop || true
rm -f /etc/nginx/sites-available/*
rm -f /etc/nginx/sites-enabled/*

cat $conf.tmpl | sed s/{{domain}}/$DOMAIN/g > /etc/nginx/sites-available/$conf
ln -s /etc/nginx/sites-available/$conf /etc/nginx/sites-enabled/$conf

sudo service nginx start
service nginx status


set +e
certbot --help
res=$?
set -e
if [ "$res" -ne 0 ]; then
    sudo apt-get update -y
    sudo apt-get install software-properties-common -y
    sudo add-apt-repository universe -y
    sudo add-apt-repository ppa:certbot/certbot -y
    sudo apt-get update -y
    sudo apt-get install python-certbot-nginx -y
fi

certbot --nginx --domains $DOMAIN --non-interactive --redirect --agree-tos -m $CERTBOT_CONTACT_EMAIL
nginx -s reload || true
systemctl daemon-reload
service nginx status

