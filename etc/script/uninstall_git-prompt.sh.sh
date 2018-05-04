#!/bin/sh

set -u
umask 0022
PATH='/usr/bin:/bin'
IFS=$(printf ' \t\n_'); IFS=${IFS%_}
export IFS LC_ALL=C LANG=C PATH

if [ -f "$HOME/.git-prompt.sh" ]; then
    rm -rf "$HOME/.git-prompt.sh"
fi

