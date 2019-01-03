#!/bin/bash

cd $(dirname "$(readlink -f "$BASH_SOURCE")")

# installs various packages
./packages.sh

# Creates netpips user and sets permissions
./user.sh 'netpips' '<password>'

# Install nginx and sets up https using certbot
./nginx.sh '<domain>' '<certbot_contact_email>'

# Install dotnet SDK
./dotnet.sh

# Installs mssql-server, sqlcmd, creates database logins and permissions
./mssql-server.sh '<sa_pwd>' '<netpips_pwd>'

# Install netpips-server as service
./netpips-server.sh 'netpips' '<env>' '<netpips_superadmin_email>'

# Install filebot and sets up opensub credentials
./filebot.sh '<opensub_login>' '<opensub_pwd>'

# Install transmission-daemon service and runs it as netpips
./transmission.sh

# Install plex service
./plexmediaserver.sh
