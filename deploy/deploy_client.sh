#!/bin/bash

set -ex

if [[ "$USER" != 'netpips' ]]; then
    echo "current user ($USER) is not 'netpips'"
    exit 1
fi


if [ ! -d /shared/Netpips.PWA ]; then
    echo "Cloning Netpips.PWA"
    git clone 'https://github.com/PierreRoudaut/Netpips.PWA.git' /shared/Netpips.PWA
    cd /shared/Netpips.PWA
else
    cd /shared/Netpips.PWA
    git pull
fi

env=${ASPNETCORE_ENVIRONMENT,}
/shared/Netpips.CI/install/environment.sh
npm install
ng build --prod --configuration=$env --output-path=/var/netpips/client

date >> /tmp/client_deployments.log
