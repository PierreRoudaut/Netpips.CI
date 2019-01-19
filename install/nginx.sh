#!/bin/bash

set -e

script_name=`basename "$0"`

if [[ "$USER" != 'root' ]]; then
    echo "./$script_name must be run as root user"
    exit 1
fi

if [ "$#" -ne 1 ]; then
    echo "./$script_name [CERTBOT_CONTACT_EMAIL]"
    exit 1
fi

domain=$DOMAIN
email=$2
conf='netpips.conf'

apt-get install -y nginx
service nginx stop || true
rm -f /etc/nginx/sites-available/*
rm -f /etc/nginx/sites-enabled/*

cat $conf.tmpl | sed s/{{domain}}/$domain/g > /etc/nginx/sites-available/$conf
ln -s /etc/nginx/sites-available/$conf /etc/nginx/sites-enabled/$conf

sudo service nginx start
service nginx status

# [Certbot]
set +e
certbot --help
set -e
if [ "$?" -ne 0 ]; then
    sudo apt-get update -y
    sudo apt-get install software-properties-common -y
    sudo add-apt-repository universe -y
    sudo add-apt-repository ppa:certbot/certbot -y
    sudo apt-get update -y
    sudo apt-get install python-certbot-nginx -y
fi

certbot --nginx --domains $domain --non-interactive --agree-tos -m $email
nginx -s reload || true
systemctl daemon-reload
service nginx status

