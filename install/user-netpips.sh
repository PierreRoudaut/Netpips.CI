#!/bin/bash
#
# - Creates netpips user
#
########################

script_name=`basename "$0"`

if [ "$#" -ne 1 ]; then
    echo "./$script_name [PASSWORD]"
    exit 1
fi

user='netpips'
password=$1

# Create user
sudo adduser --disabled-password --gecos "" $user
if [ "$?" -eq 0 ]; then
    echo "$user:$password" | chpasswd
fi

# Netpips as sudo
sudo usermod -aG sudo netpips

sudo chown netpips:netpips /shared

# Torrent done script
sudo cp '.torrent_done.sh' /home/$user/
sudo chmod 777 /home/$user/'.torrent_done.sh'
sudo chown "$user:$user" /home/$user/'.torrent_done.sh'

# Create directories
sudo mkdir -m777 -p /home/$user/downloads
sudo mkdir -m777 -p /home/$user/logs

sudo mkdir -m777 -p /home/$user/medialibrary
sudo mkdir -m777 -p /home/$user/medialibrary/TV\ Shows
sudo mkdir -m777 -p /home/$user/medialibrary/Movies
sudo mkdir -m777 -p /home/$user/medialibrary/Others
sudo mkdir -m777 -p /home/$user/medialibrary/Music
sudo mkdir -m777 -p /home/$user/medialibrary/Podcasts
sudo chown -R "$user:$user" /home/$user/

sudo mkdir -p /var/$user/server
sudo mkdir -p /var/$user/client
sudo echo 'Hello, world !' > /var/$user/client/index.html
sudo chown -R "$user:$user" /var/$user/

echo "user.sh => OK"
