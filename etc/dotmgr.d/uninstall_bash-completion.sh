#!/bin/sh

set -u

if [ -d "$HOME/usr/bash-completion" ]; then
    rm -rfv "$HOME/usr/bash-completion"
fi

