#!/bin/bash

set -e

if [[ "$USER" != 'netpips-deployment' ]]; then
    echo "current user ($USER) is not 'netpips-deployment'"
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

cd /tmp/Netpips.Server/Netpips
git pull
git checkout $BRANCH
dotnet restore
sudo service $srvc stop 2> /dev/null || true
source ~/.netpipsvarenv.sh
dotnet ef database update
dotnet publish -c 'Release' -o '/var/netpips/server'
sudo service $srvc start
sudo service $srvc status
date >> /tmp/deployments.log
