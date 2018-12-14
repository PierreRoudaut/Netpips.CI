#!/bin/bash

script_name=`basename "$0"`

if [ "$#" -ne 2 ]; then
    echo "./$script_name [USER] [PASSWORD]"
    exit 1
fi

user=$1
password=$2

adduser --disabled-password --gecos "" $user
if [ "$?" -eq 0 ]; then
    echo "$user:$password" | chpasswd
fi

# Create working directories
cp .torrent_done.sh /home/$user/
mkdir -p /home/$user/downloads
mkdir -p /home/$user/logs

mkdir -p /home/$user/medialibrary
mkdir -p /home/$user/medialibrary/TV\ Shows
mkdir -p /home/$user/medialibrary/Movies
mkdir -p /home/$user/medialibrary/Others
mkdir -p /home/$user/medialibrary/Music

chmod 777 -R /home/$user
chown -R "$user:$user" /home/$user/

