#!/bin/sh

set -u
umask 0022
PATH='/usr/bin:/bin'
IFS=$(printf ' \t\n_'); IFS=${IFS%_}
export IFS LC_ALL=C LANG=C PATH

if [ -d "$HOME/usr/bash-completion" ]; then
    rm -rf "$HOME/usr/bash-completion"
fi

