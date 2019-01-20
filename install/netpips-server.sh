#!/bin/bash
## Installs netpips-server service
##
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

# requires appsettings for connection string
su - $user -c "cd /shared/Netpips.Server/Netpips; dotnet restore; dotnet build; dotnet ef database update"
/opt/mssql-tools/bin/sqlcmd -U sa -P $MSSQL_SA_PASSWORD -Q "USE netpips INSERT INTO Users (Id, Email, Role) VALUES ('00000000-0000-0000-0000-000000000000', '', 'SuperAdmin')"

