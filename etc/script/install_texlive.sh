#!/bin/sh

set -u
umask 0022
PATH='/usr/bin:/bin'
IFS=$(printf ' \t\n_'); IFS=${IFS%_}
export IFS LC_ALL=C LANG=C PATH

path_tmproot="$HOME/tmp$$"

url_texlive="mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz"

url_texrepo="http://ftp.jaist.ac.jp/pub/CTAN/systems/texlive/tlnet"

trap '
    if [ -d "$path_tmproot" ]; then
        rm -rf "$path_tmproot"
    fi
' 1 2 3 15

if ! type wget > /dev/null 2>&1; then
    printf "ERROR: command \"wget\" not found.\\n" 1>&2
    exit 1
fi

mkdir "$path_tmproot"
cd "$path_tmproot" || exit

if [ ! -d "$HOME/usr/texlive" ]; then
    mkdir -p "$HOME/usr/texlive"
fi

if type curl > /dev/null 2>&1; then
    curl -L "$url_texlive" | tar xzv &&
    cd "$(find "$path_tmproot" -maxdepth 1 |
          grep -e "install-tl")" || exit
    printf "I\\n" |
    TEXLIVE_INSTALL_PREFIX="$HOME/usr/texlive" ./install-tl --repository "$url_texrepo"
elif type wget > /dev/null 2>&1; then
    wget -O - "$url_texlive" | tar xzv &&
    cd "$(find "$path_tmproot" -maxdepth 1 |
          grep -e "install-tl")" || exit
    printf "I\\n" |
    TEXLIVE_INSTALL_PREFIX="$HOME/usr/texlive" ./install-tl --repository "$url_texrepo"
fi

cd "$HOME" || exit
if [ -d "$path_tmproot" ]; then
    rm -rf "$path_tmproot"
fi

