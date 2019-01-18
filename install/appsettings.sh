#!/bin/bash

set -e

script_name=`basename "$0"`

if [ "$#" -ne 1 ]; then
    echo "./$script_name [APPSETTINGS_URL]"
    exit 1
fi

id=$(echo $1 | grep -oP '(?<='id=')[^;]*')
url="https://drive.google.com/uc?export=download&id=$id"
su - netpips -c "cd /home/netpips && curl -L '$url' -O -J"
