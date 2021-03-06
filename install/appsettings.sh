#!/bin/bash

set -ex

: "${APPSETTINGS_ID:?APPSETTINGS_ID not set}"
: "${APPSETTINGS_TEST_ID:?APPSETTINGS_TEST_ID not set}"

appsettings_url="https://drive.google.com/uc?export=download&id=$APPSETTINGS_ID"
appsettings_test_url="https://drive.google.com/uc?export=download&id=$APPSETTINGS_TEST_ID"

rm -f /home/netpips/netpips.*.settings.json

if [[ "$USER" = 'root' ]]; then
    su - netpips -c "cd /home/netpips && curl -L '$appsettings_url' -O -J 2> /dev/null"
    su - netpips -c "cd /home/netpips && curl -L '$appsettings_test_url' -O -J 2> /dev/null"
else
    cd /home/netpips && curl -L "$appsettings_url" -O -J 2> /dev/null
    cd /home/netpips && curl -L "$appsettings_test_url" -O -J 2> /dev/null
fi



