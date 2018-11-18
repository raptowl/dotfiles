#!/bin/sh

set -e -u
umask 0022

path_tmproot="$HOME/tmp$$"
url_texlive='mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz'
url_texrepo='http://ftp.jaist.ac.jp/pub/CTAN/systems/texlive/tlnet'

trap '
	if [ -d "$path_tmproot" ]; then
		rm -rf "$path_tmproot"
	fi
' 1 2 3 15

if ! type wget >/dev/null 2>&1; then
	printf 'ERROR: command wget not found.\n' >&2
	exit 1
fi

if [ ! -d "$HOME/usr" ]; then
	mkdir -p "$HOME/usr"
fi

mkdir -p "$path_tmproot"
cd "$path_tmproot"

if type curl >/dev/null 2>&1; then
	curl -L "$url_texlive" |
		tar xzv
elif type wget >/dev/null 2>&1; then
	wget -O - "$url_texlive" |
		tar xzv
fi
cd "$(find "$path_tmproot" -maxdepth 1 |
	grep -e "install-tl")"
printf 'I\n' |
	TEXLIVE_INSTALL_PREFIX="$HOME/usr/texlive" ./install-tl --repository "$url_texrepo"

if [ -d "$path_tmproot" ]; then
	rm -rf "$path_tmproot"
fi
