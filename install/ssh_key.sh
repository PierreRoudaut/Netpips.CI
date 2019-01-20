#!/bin/bash

set -e

su - netpips -c "rm -rf ~/.ssh"
su - netpips -c "mkdir -m700 ~/.ssh"
su - netpips -c "ssh-keygen -f ~/.ssh/circleci -m pem -N ''"
su - netpips -c "cat ~/.ssh/circleci.pub >> ~/.ssh/authorized_keys"
su - netpips -c "chmod 640 ~/.ssh/authorized_keys"

echo "Copy/Paste the PK to CircleCI"
cat /home/netpips/.ssh/circleci
