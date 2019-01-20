#!/bin/bash

set -e

if [[ "$USER" != 'netpips' ]]; then
    echo "current user ($USER) is not 'netpips'"
    exit 1
fi


srvc='netpips-server'

if [ ! -d /tmp/Netpips.Server ]; then
    echo "Cloning Netpips.Server"
    git clone 'https://github.com/PierreRoudaut/Netpips.Server.git' /shared/Netpips.Server
fi

# Update source
cd /shared/Netpips.Server/Netpips
git pull
git checkout master
dotnet restore
sudo service $srvc stop 2> /dev/null || true

# Update database schema
#source ~/.netpipsvarenv
#dotnet ef database update

# Deploy
dotnet publish -c 'Release' -o '/var/netpips/server'
sudo service $srvc start
sudo service $srvc status
date >> /tmp/deployments.log
