#!/bin/bash

set -e

service plexmediaserver stop &> /dev/null || true
wget -O pms.deb "https://plex.tv/downloads/latest/1?channel=8&build=linux-ubuntu-x86_64&distro=ubuntu&X-Plex-Token=9DKJgsYYMmfdwL2U2JoG"
dpkg -i pms.deb
rm -f   pms.deb
service plexmediaserver status
