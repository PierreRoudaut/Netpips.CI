#!/bin/bash

apt-get install -y git
mkdir -m777 /shared/
chown netpips:netpips /shared
git clone 'https://github.com/PierreRoudaut/Netpips.CI.git' /shared/Netpips.CI

