#!/bin/bash

set -e

wget -q https://packages.microsoft.com/config/ubuntu/16.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm -f packages-microsoft-prod.deb
sudo apt-get -y install apt-transport-https
sudo apt-get update
sudo apt-get install -y dotnet-sdk-2.1
