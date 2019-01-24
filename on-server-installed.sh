#!/bin/bash

apt-get install -y git
git clone 'https://github.com/PierreRoudaut/Netpips.CI.git' /tmp/Netpips.CI
sh /tmp/Netpips.CI/install/install.sh

