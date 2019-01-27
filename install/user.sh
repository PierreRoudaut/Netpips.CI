#!/bin/bash
#
# - Creates netpips user
#
########################

script_name=`basename "$0"`

if [[ "$USER" != 'root' ]]; then
    echo "./$script_name must be run as root user"
    exit 1
fi

if [ "$#" -ne 1 ]; then
    echo "./$script_name [PASSWORD]"
    exit 1
fi

user='netpips'
password=$1

# Create user
adduser --disabled-password --gecos "" $user
if [ "$?" -eq 0 ]; then
    echo "$user:$password" | chpasswd
fi

# Netpips as sudo
usermod -aG sudo netpips

chown netpips:netpips /shared

# Torrent done script
cp '.torrent_done.sh' /home/$user/
chmod 777 /home/$user/'.torrent_done.sh'
chown "$user:$user" /home/$user/'.torrent_done.sh'

# Create directories
mkdir -m666 -p /home/$user/downloads
mkdir -m666 -p /home/$user/logs

mkdir -m666 -p /home/$user/medialibrary
mkdir -m666 -p /home/$user/medialibrary/TV\ Shows
mkdir -m666 -p /home/$user/medialibrary/Movies
mkdir -m666 -p /home/$user/medialibrary/Others
mkdir -m666 -p /home/$user/medialibrary/Music
mkdir -m666 -p /home/$user/medialibrary/Podcasts
chown -R "$user:$user" /home/$user/

mkdir -p /var/$user/server
mkdir -p /var/$user/client
echo 'Hello, world !' > /var/$user/client/index.html
chown -R "$user:$user" /var/$user/

echo "user.sh => OK"
