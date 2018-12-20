#!/bin/bash

set -e
if [[ "$USER" != 'netpips' ]]; then
    echo "current user ($USER) is not 'netpips'"
    exit 1
fi

ssh-keygen -m pem

