#!/bin/sh

set -u

if [ -d "$HOME/usr/bash-completion" ]; then
    rm -rf "$HOME/usr/bash-completion"
fi

