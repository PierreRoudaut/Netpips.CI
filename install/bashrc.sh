#!/bin/bash

set -x

(cat ~/.bashrc | grep 'alias ne=' &> /dev/null)
if [ "$?" -ne 0 ]; then
    echo "alias ne='emacs'" >> ~/.bashrc
fi

(cat ~/.bashrc | grep 'alias cdd=' &> /dev/null)
if [ "$?" -ne 0 ]; then
    echo "alias cdd='cd ../'" >> ~/.bashrc
fi

(cat ~/.bashrc | grep 'alias visudo=' &> /dev/null)
if [ "$?" -ne 0 ]; then
    echo "alias visudo='EDITOR=emacs visudo'" >> ~/.bashrc
fi

