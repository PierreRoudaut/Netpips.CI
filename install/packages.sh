#!/bin/bash


sudo apt-get update -y
sudo apt-get install -y bash-completion
sudo apt-get install -y aria2
sudo apt-get install -y emacs
sudo apt-get install -y git
sudo apt-get install -y htop
sudo apt-get install -y jq
sudo apt-get install -y mediainfo
sudo apt-get install -y tree
sudo apt-get install -y nodejs
sudo apt-get install -y python3.9
sudo apt-get install -y python3-pip
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.9
sudo pip install -U cfscrape


git config --global core.editor 'emacs'
