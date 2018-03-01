#!/bin/bash

# define variables.
DOT_PATH="$HOME/.dotfiles"
DOT_GITURL="github.com/raptowl/dotfiles.git"
DOT_TARURL="github.com/raptowl/dotfiles/archive/master.tar.gz"

############################################################

if [ $# -eq 0 ]; then
    :
elif [ $# -eq 1 ]; then
    if [ $1 = "deploy" ]; then
        echo "deploy test"
        exit 0
    elif [ $1 = "install" ]; then
        echo "install test"
        exit 0
    else
        echo "Error: instruction $1 is not defined." 1>&2
        exit 1
    fi
else
    echo "Error: the number of arguments is incorrect." 1>&2
    exit 1
fi

