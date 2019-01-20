#!/bin/bash
#
# - Insert netpips SuperAdmin
#
##################################

set -exu

if [ "$#" -ne 1 ]; then
    echo "./$script_name [SUPERADMIN_GMAIL]"
    exit 1
fi
SUPERADMIN_GMAIL=$1

pwd=$(cat /home/netpips/netpips.staging.settings.json | jq .ConnectionStrings.Default --raw-output | cut -d'=' -f6)

/opt/mssql-tools/bin/sqlcmd -U 'netpips' -P $pwd -Q "USE netpips INSERT INTO Users (Id, Email, Role) VALUES ('00000000-0000-0000-0000-000000000000', '$SUPERADMIN_GMAIL', 'SuperAdmin')"

