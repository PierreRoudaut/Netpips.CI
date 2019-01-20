#!/bin/bash
#
# - Installs netpips-server service
#
##################################

set -exu

user='netpips'
srvc='netpips-server'

: "${ASPNETCORE_ENVIRONMENT:?ASPNETCORE_ENVIRONMENT not set}"

systemctl disable $srvc.service || true
rm -f /etc/systemd/system/$srvc.service
cat $srvc.service.tmpl | sed s/{{env}}/$ASPNETCORE_ENVIRONMENT/g | sed s/{{user}}/$user/g  > /etc/systemd/system/$srvc.service
systemctl daemon-reload
systemctl enable $srvc.service
service $srvc stop


