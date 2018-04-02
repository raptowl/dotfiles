#!/bin/sh

set -u

if [ -d "$HOME/usr/bash-completion" ]; then
    rm -rvf "$HOME/usr/bash-completion"
fi

