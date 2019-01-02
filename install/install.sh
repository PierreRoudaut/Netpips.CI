#!/bin/bash

cd $(dirname "$(readlink -f "$BASH_SOURCE")")

# Packages
./packages.sh

# Netpips user
## ./user.sh

# Nginx
./nginx.sh

# Service
./service.sh

# Dotnet
./dotnet.sh

# SQL Server
./sqlserver.sh

# Filebot
./filebot.sh

# Transmission
##./transmission.sh
