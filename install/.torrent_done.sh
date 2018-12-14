#!/bin/bash

if [ $# -eq 1 ]; then
    TR_TORRENT_HASH=$1
fi

curl "http://localhost:5000/api/torrentDone/$TR_TORRENT_HASH"
