#!/bin/bash

apt-get update -y

for package in `cat packages.txt`
do
    apt-get install -y "$package" > /dev/null
done
git config --global core.editor 'emacs'
