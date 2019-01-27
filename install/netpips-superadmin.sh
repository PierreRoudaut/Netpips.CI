#!/bin/bash
#
# - Insert netpips SuperAdmin
#
##################################

set -exu
script_name=`basename "$0"`

if [ "$#" -ne 1 ]; then
    echo "./$script_name [SUPERADMIN_GMAIL]"
    exit 1
fi
SUPERADMIN_GMAIL=$1
cs=$(cat /home/netpips/netpips.${ASPNETCORE_ENVIRONMENT,}.settings.json | jq .ConnectionStrings.Default --raw-output)
NETPIPS_LOGIN_PASSWORD=$(python -c "print '$cs'.split(';')[-1].split('=')[1]")

q="SET QUOTED_IDENTIFIER ON USE NETPIPS INSERT INTO Users (Id, Email, Role) VALUES ('00000000-0000-0000-0000-000000000000', '$SUPERADMIN_GMAIL', 'SuperAdmin')"
echo $q
/opt/mssql-tools/bin/sqlcmd -U 'netpips' -P $NETPIPS_LOGIN_PASSWORD -Q "$q"

