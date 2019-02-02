#!/bin/bash

set -ex

: "${ENVIRONMENT_ID:?ENVIRONMENT_ID not set}"

env_url="https://drive.google.com/uc?export=download&id=$ENVIRONMENT_ID"

env=${ASPNETCORE_ENVIRONMENT,}
echo $env
echo /shared/Netpips.PWA/src/environments/environment.$env.settings.json

rm -f /shared/Netpips.PWA/src/environments/environment.$env.settings.json
ls -la  /shared/Netpips.PWA/src/environments/

if [[ "$USER" = 'root' ]]; then
    su - netpips -c "cd /shared/Netpips.PWA/src/environments && curl -L '$appsettings_url' -O -J 2> /dev/null"
else
    cd /shared/Netpips.PWA/src/environments && curl -L "$env_url" -O -J
fi
