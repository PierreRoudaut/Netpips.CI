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

# Filebot
./filebot.sh

# Transmission
##./transmission.sh
