#!/bin/bash

conf='netpips.conf'

service $conf stop
service nginx stop
rm -f /etc/nginx/sites-available/$conf
rm -f /etc/nginx/sites-enabled/$conf

cp $conf /etc/nginx/sites-available/$conf
ln -s /etc/nginx/sites-available/$conf /etc/nginx/sites-enabled/$conf

nginx -t
nginx -s reload

service nginx start
service nginx status
