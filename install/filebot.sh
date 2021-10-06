#!/bin/bash

set -e

script_name=`basename "$0"`

if [ "$#" -ne 2 ]; then
    echo "./$script_name [OPENSUB_USERNAME] [OPENSUB_PASSWORD]"
    exit 1
fi

username=$1
password=$2

sudo apt-get install -y default-jre
sudo apt-get install -y default-jdk
sudo apt-get install -y libjna-java

wget -O filebot.deb 'https://app.filebot.net/download.php?type=deb&arch=amd64'
sudo dpkg -i filebot.deb
rm -f   filebot.deb
filebot -version

echo -e "$username\n$password" | filebot -script fn:configure
