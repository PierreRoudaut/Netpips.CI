#!/bin/bash

set -e

script_name=`basename "$0"`

if [[ "$USER" != 'root' ]]; then
    echo "./$script_name must be run as root user"
    exit 1
fi

wget -q https://packages.microsoft.com/config/ubuntu/16.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt-get -y install apt-transport-https
sudo apt-get update
sudo apt-get install -y dotnet-sdk-2.1
