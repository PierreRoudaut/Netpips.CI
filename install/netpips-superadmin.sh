#!/bin/bash
#
# - Insert netpips SuperAdmin
#
##################################

set -exu
script_name=`basename "$0"`

if [ "$#" -ne 2 ]; then
    echo "./$script_name [SUPERADMIN_GMAIL] [NETPIPS_LOGIN_PASSWORD]"
    exit 1
fi
SUPERADMIN_GMAIL=$1
NETPIPS_LOGIN_PASSWORD=$2

q="SET QUOTED_IDENTIFIER ON USE NETPIPS INSERT INTO Users (Id, Email, Role) VALUES ('00000000-0000-0000-0000-000000000000', '$SUPERADMIN_GMAIL', 'SuperAdmin')"
echo $q
/opt/mssql-tools/bin/sqlcmd -U 'netpips' -P $NETPIPS_LOGIN_PASSWORD -Q "$q"

