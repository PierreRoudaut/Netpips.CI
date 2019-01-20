#!/bin/bash

cd $(dirname "$(readlink -f "$BASH_SOURCE")")

# Install transmission-daemon service and runs it as netpips
./transmission.sh

# Install plex service
./plexmediaserver.sh

# installs various packages
./packages.sh

# Install dotnet SDK
./dotnet.sh

exit 0

#########
# MANUAL
#########

# >>> README.md, reboot

./appsettings.sh

# Creates netpips user and sets permissions
./user.sh '<password>'

# requires 
./nginx.sh

# Installs mssql-server, sqlcmd, creates database logins and permissions
./mssql-server.sh '<sa_pwd>'

# Install netpips-server as service
./netpips-server.sh

../deploy/deploy-server.sh

# Install filebot and sets up opensub credentials
./filebot.sh '<opensub_login>' '<opensub_pwd>'
./ssh_key.sh
./netpips-superadmin.sh '<netpips_superadmin_email>'
