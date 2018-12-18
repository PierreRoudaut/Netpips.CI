#!/bin/bash

set -e

script_name=`basename "$0"`

if [[ "$USER" != 'root' ]]; then
    echo "./$script_name must be run as root user"
    exit 1
fi

if [ "$#" -ne 2 ]; then
    echo "./$script_name [HOST] [CERTBOT_CONTACT_EMAIL]"
    exit 1
fi

host=$1
email=$2
conf='netpips.conf'

service netpips-server stop || true
service nginx stop || true
rm -f /etc/nginx/sites-available/$conf
rm -f /etc/nginx/sites-enabled/$conf

cat $conf.tmpl | sed s/{{host}}/$host/g > /etc/nginx/sites-available/$conf
ln -s /etc/nginx/sites-available/$conf /etc/nginx/sites-enabled/$conf

nginx -t
nginx -s reload || true

sudo service nginx start
service nginx status

# [Certbot]
ex=$(certbot --help)
if [ "$?" -ne 0 ]; then
    sudo apt-get update -y
    sudo apt-get install software-properties-common -y
    sudo add-apt-repository universe -y
    sudo add-apt-repository ppa:certbot/certbot -y
    sudo apt-get update -y
    sudo apt-get install python-certbot-nginx -y
fi

certbot --nginx --domains $host --non-interactive --agree-tos -m $email
service nginx status
service netpips-server restart || true
