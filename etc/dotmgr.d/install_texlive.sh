#!/bin/sh

path_tmproot="$HOME/tmp$$"
url_texlive="mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz"

trap '
    if [ -d "$path_tmproot" ]; then
        rm -rf "$path_tmproot"
    fi
' 1 2 3 15

mkdir "$path_tmproot"
cd "$path_tmproot" || exit

if [ ! -d "$HOME/usr/texlive" ]; then
    mkdir -p "$HOME/usr/texlive"
fi

if command -v wget > /dev/null 2>&1; then
    wget -O - "$url_texlive" | tar xzv &&
    cd "$(find "$path_tmproot" -maxdepth 1 |
          grep -e "install-tl")" || exit
    printf "I\\n" |
    TEXLIVE_INSTALL_PREFIX="$HOME/usr/texlive" ./install-tl
elif command -v curl > /dev/null 2>&1; then
    curl -L "$url_texlive" | tar xzv &&
    cd "$(find "$path_tmproot" -maxdepth 1 |
          grep -e "install-tl")" || exit
    printf "I\\n" |
    TEXLIVE_INSTALL_PREFIX="$HOME/usr/texlive" ./install-tl
else
    printf "ERROR: command \"wget\" or \"curl\" not found.\\n" 1>&2
    exit 1
fi

cd "$HOME" || exit
rm -rf "$path_tmproot"

