#!/bin/bash

set -ex

if [[ "$USER" != 'netpips' ]]; then
    echo "current user ($USER) is not 'netpips'"
    exit 1
fi

srvc='netpips-server'

if [ ! -d /shared/Netpips.Server ]; then
    echo "Cloning Netpips.Server"
    git clone 'https://github.com/PierreRoudaut/Netpips.Server.git' /shared/Netpips.Server
    cd /shared/Netpips.Server/Netpips
else
    cd /shared/Netpips.Server/Netpips
    git pull
fi

dotnet restore

sudo service $srvc stop 2> /dev/null || true

## Install appsettings
/shared/Netpips.CI/install/appsettings.sh

## Update database schema
dotnet ef database update

## Deploy
dotnet publish -c 'Release' -o '/var/netpips/server'
sudo service $srvc start
sudo service $srvc status
date >> /tmp/server_deployments.log
