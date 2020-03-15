#!/bin/bash

set -ex
sudo mkdir /mnt/ramdisk
sudo mount -t tmpfs -o rw,size=22G tmpfs /mnt/ramdisk

# cp /etc/fstab /etc/fstab.bak
# sudo echo 'tmpfs  /mnt/ramdisk  tmpfs  rw,size=2G  0   0' >> /etc/fstab
