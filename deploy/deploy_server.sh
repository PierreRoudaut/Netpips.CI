#!/bin/bash

set -ex

script_name=`basename "$0"`

if [[ "$USER" != 'netpips' ]]; then
    echo "current user ($USER) is not 'netpips'"
    exit 1
fi

if [[ "$#" -ne 1 ]]; then
    echo "./$script_name [VERSION]
    exit 1
fi

VERSION=$1

cd ../../Netpips.Server/Netpips
git pull
git checkout tags/netpips-server-$VERSION
dotnet restore
dotnet build
sudo service netpips-server stop 2> /dev/null || true
dotnet ef database update
dotnet publish -c 'Release' -o '/var/netpips/server'
sudo service netpips-server start
sudo service netpips-server status
