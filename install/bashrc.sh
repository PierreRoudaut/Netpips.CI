#!/bin/bash

(alias ne 2> /dev/null)
if [ "$?" -ne 0]; then
    echo "alias ne='emacs'" >> ~/.bashrc
fi

(alias cdd 2> /dev/null)
if [ "$?" -ne 0]; then
    echo "alias cdd='cd ../'" >> ~/.bashrc
fi

source ~/.bashrc
