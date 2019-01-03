#!/bin/bash

set -e

script_name=`basename "$0"`

if [[ "$USER" != 'root' ]]; then
    echo "./$script_name must be run as root user"
    exit 1
fi

if [ "$#" -ne 2 ]; then
    echo "./$script_name [MSSQL_SA_PASSWORD] [NETPIPS_LOGIN_PASSWORD]"
    exit 1
fi
MSSQL_SA_PASSWORD=$1
NETPIPS_LOGIN_PASSWORD=$2

# mssql-server
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
sudo add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/16.04/mssql-server-2017.list)"
sudo apt-get update
sudo apt-get install -y mssql-server
service mssql-server stop
sudo ACCEPT_EULA='Y' MSSQL_PID='Express' MSSQL_SA_PASSWORD=$MSSQL_SA_PASSWORD /opt/mssql/bin/mssql-conf -n setup
systemctl status mssql-server || true

# sqlcmd
echo "installing sqlcmd"
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list | sudo tee /etc/apt/sources.list.d/msprod.list
sudo apt-get update
sudo ACCEPT_EULA='Y' DEBIAN_FRONTEND=noninteractive apt-get install -y mssql-tools unixodbc-dev
PATH="$PATH:/opt/mssql-tools/bin"

# database, logins and permissions
sqlcmd -U sa -P $MSSQL_SA_PASSWORD -Q "CREATE DATABASE netpips"
sqlcmd -U sa -P $MSSQL_SA_PASSWORD -Q "CREATE LOGIN netpips WITH PASSWORD = '$NETPIPS_LOGIN_PASSWORD', CHECK_EXPIRATION = OFF, CHECK_POLICY = OFF;"
sqlcmd -U sa -P $MSSQL_SA_PASSWORD -Q "USE netpips CREATE USER [app-user] FROM LOGIN netpips WITH DEFAULT_SCHEMA = dbo"
sqlcmd -U sa -P $MSSQL_SA_PASSWORD -Q "USE netpips EXEC sp_addrolemember 'db_owner', 'app-user'"
