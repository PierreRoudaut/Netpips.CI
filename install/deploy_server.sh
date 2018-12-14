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

rm -rf Netpips.Server
# todo: optimize reclone of Netpips.Server
git clone 'https://github.com/PierreRoudaut/Netpips.Server.git' && cd Netpips.Server/Netpips
git checkout $BRANCH
dotnet restore
sudo service $srvc stop 2> /dev/null || true
dotnet ef database update
dotnet publish -c 'Release' -o '/var/netpips/server'
sudo service $srvc start
sudo service $srvc status
cd ../../ && rm -rf Netpips.Server
# update deployment log

