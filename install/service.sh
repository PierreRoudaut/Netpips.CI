#!/bin/bash

script_name=`basename "$0"`
if [ "$#" -ne 2 ]; then
    echo "./$script_name [RUNAS_USER] [ASPNETCORE_ENV] (Development | Staging | Production)"
    exit 1
fi

user=$1
env=$2
srvc='netpips-server'

systemctl disable $srvc.service
rm -f /etc/systemd/system/$srvc.service
cat $srvc.service.tmpl | sed s/{{env}}/$env/g | sed s/{{user}}/$user/g  > /etc/systemd/system/$srvc.service
systemctl daemon-reload
systemctl enable $srvc.service
service $srvc start
service $srvc status

