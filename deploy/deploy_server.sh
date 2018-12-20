#!/bin/bash

set -e

if [[ "$USER" != 'netpips' ]]; then
    echo "current user ($USER) is not 'netpips'"
    exit 1
fi

script_name=`basename "$0"`
if [ "$#" -ne 1 ]; then
    echo "./$script_name [BRANCH]"
   exit 1
fi

BRANCH=$1
srvc='netpips-server'

if [ ! -d /tmp/Netpips.Server ]; then
    echo "Cloning repo"
    git clone 'https://github.com/PierreRoudaut/Netpips.Server.git' /tmp/Netpips.Server
fi

# Update source
cd /tmp/Netpips.Server/Netpips
git pull
git checkout $BRANCH
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
