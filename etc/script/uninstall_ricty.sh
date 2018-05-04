#!/bin/sh

set -u
umask 0022
PATH='/usr/bin:/bin'
IFS=$(printf ' \t\n_'); IFS=${IFS%_}
export IFS LC_ALL=C LANG=C PATH

find "$HOME/.fonts" -maxdepth 1 |
grep -e "Ricty" |
xargs rm -rf

