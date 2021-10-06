#!/bin/bash

set -e

script_name=`basename "$0"`

if [ "$#" -ne 3 ]; then
    echo "./$script_name [OPENSUB_USERNAME] [OPENSUB_PASSWORD] [FILEBOT_LICENSE_PATH]"
    exit 1
fi

OPENSUB_USERNAME=$1
OPENSUB_PASSWORD=$2
FILEBOT_LICENSE_PATH=$3

sudo apt-get install -y default-jre
sudo apt-get install -y default-jdk
sudo apt-get install -y libjna-java

wget -O filebot.deb 'https://app.filebot.net/download.php?type=deb&arch=amd64'
sudo dpkg -i filebot.deb
rm -f   filebot.deb
filebot -version

echo -e "$OPENSUB_USERNAME\n$OPENSUB_PASSWORD" | filebot -script fn:configure
filebot --license $FILEBOT_LICENSE_PATH
