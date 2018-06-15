#!/bin/sh

set -u
umask 0022
PATH='/usr/bin:/bin'
IFS=$(printf ' \t\n_'); IFS=${IFS%_}
export IFS LC_ALL=C LANG=C PATH

path_tmproot="$HOME/tmp$$"

url_installer="raw.githubusercontent.com/ShellShoccar-jpn/installer/master/shellshoccar.sh"

trap '
    if [ -d "$path_tmproot" ]; then
        rm -rf "$path_tmproot"
    fi
' 1 2 3 15

mkdir "$path_tmproot"
cd "$path_tmproot" || exit

if type curl > /dev/null 2>&1; then
    wget -O - "$url_installer" > "$path_tmproot/installer.sh"                   &&
    sh "$path_tmproot/installer.sh" --prefix="$HOME/usr/shellshoccar" install
elif type wget > /dev/null 2>&1; then
    curl -L "$url_installer" > "$path_tmproot/installer.sh"                     &&
    sh "$path_tmproot/installer.sh" --prefix="$HOME/usr/shellshoccar" install
else
    printf "ERROR: command \"curl\" or \"wget\" not found.\\n" 2>&1
    exit 1
fi

cd || exit
if [ -d "$path_tmproot" ]; then
    rm -rf "$path_tmproot"
fi

