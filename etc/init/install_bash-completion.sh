#!/bin/sh

set -u

path_tmproot="$HOME/tmp$$"

url_gitrepo="https://github.com/scop/bash-completion.git"

url_tarball="github.com/scop/bash-completion/archive/master.tar.gz"

trap '
    if [ -d "$path_tmproot" ]; then
        rm -rf "$path_tmproot"
    fi
' 1 2 3 15

if ! command -v autoreconf > /dev/null 2>&1; then
    printf "ERROR: command \"autoreconf\" not found.\\n" 1>&2
    exit 1
fi

if ! command -v make > /dev/null 2>&1; then
    printf "ERROR: command \"make\" not found.\\n" 1>&2
    exit 1
fi

mkdir "$path_tmproot"
cd "$path_tmproot" || exit
if command -v git > /dev/null 2>&1; then
    git clone "$url_gitrepo" "$path_tmproot/bash-completion" &&
    cd "$path_tmproot/bash-completion" || exit
    autoreconf -i &&
    ./configure --prefix="$HOME/usr/bash-completion" &&
    make &&
    make install
elif command -v wget > /dev/null 2>&1; then
    wget -O - "$url_tarball" | tar xvz &&
    cd "$path_tmproot/bash-completion-master" || exit
    autoreconf -i &&
    ./configure --prefix="$HOME/usr/bash-completion" &&
    make &&
    make install
elif command -v curl > /dev/null 2>&1; then
    curl -L "$url_tarball" | tar xvz &&
    cd "$path_tmproot/bash-completion-master" || exit
    autoreconf -i &&
    ./configure --prefix="$HOME/usr/bash-completion" &&
    make &&
    make install
else
    printf "ERROR: command \"git\", \"wget\" or \"curl\" not found.\\n" 1>&2
    exit 1
fi

if [ -d "$path_tmproot" ]; then
    rm -rf "$path_tmproot"
fi

