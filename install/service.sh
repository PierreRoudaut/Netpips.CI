#!/bin/bash

script_name=`basename "$0"`
if [ "$#" -ne 1 ]; then
    echo "./$script_name [Development | Staging | Production]"
    exit 1
fi

env=$1
srvc='netpips-server'

systemctl disable $srvc.service
rm -f /etc/systemd/system/$srvc.service
cat $srvc.service.tmpl | sed s/{{env}}/$env/g  > /etc/systemd/system/$srvc.service
systemctl daemon-reload
systemctl enable $srvc.service
service $srvc start
service $srvc status

