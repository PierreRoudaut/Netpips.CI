#!/bin/bash

cd $(dirname "$(readlink -f "$BASH_SOURCE")")

# Packages
./packages.sh

