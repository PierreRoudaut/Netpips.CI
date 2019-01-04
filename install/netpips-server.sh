#!/bin/bash

set -ex

echo "Installing netpips-server as a service"
script_name=`basename "$0"`
if [ "$#" -ne 2 ]; then
    echo "./$script_name [RUNAS_USER] [ASPNETCORE_ENV] (Development | Staging | Production)"
    exit 1
fi

user=$1
env=$2
srvc='netpips-server'

systemctl disable $srvc.service || true
rm -f /etc/systemd/system/$srvc.service
cat $srvc.service.tmpl | sed s/{{env}}/$env/g | sed s/{{user}}/$user/g  > /etc/systemd/system/$srvc.service
systemctl daemon-reload
systemctl enable $srvc.service
service $srvc stop

su - $user -c "git clone 'https://github.com/PierreRoudaut/Netpips.Server.git' /tmp/Netpips.Server"
# requires appsettings for connection string
su - $user -c "cd /tmp/Netpips.Server/Netpips; dotnet restore; dotnet build; dotnet ef database update"
/opt/mssql-tools/bin/sqlcmd -U sa -P $MSSQL_SA_PASSWORD -Q "USE netpips INSERT INTO Users (Id, Email, Role) VALUES ('00000000-0000-0000-0000-000000000000', '', 'SuperAdmin')"


echo "done"
