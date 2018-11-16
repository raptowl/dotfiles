#!/bin/sh

set -e -u
umask 0022

path_tmproot="$HOME/tmp$$"
path_fonts_to_set="$HOME/.local/share/fonts"
url_inconsolata_r='github.com/google/fonts/raw/master/ofl/inconsolata/Inconsolata-Regular.ttf'
url_inconsolata_b='github.com/google/fonts/raw/master/ofl/inconsolata/Inconsolata-Bold.ttf'
url_migu='ja.osdn.jp/projects/mix-mplus-ipa/downloads/63545/migu-1m-20150712.zip'

trap '
	if [ -d "$path_tmproot" ]; then
		rm -rf "$path_tmproot"
	fi
' 1 2 3 15

if ! type unzip >/dev/null 2>&1; then
	printf 'ERROR: command unzip not found.\n' >&2
	exit 1
fi

if [ ! -d "$path_fonts_to_set" ]; then
	mkdir -p "$path_fonts_to_set"
fi
mkdir "$path_tmproot"
cd "$path_tmproot"
if type curl >/dev/null 2>&1; then
	curl -L "$url_inconsolata_r" >"$path_fonts_to_set/Inconsolata-Regular.ttf"
	curl -L "$url_inconsolata_b" >"$path_fonts_to_set/Inconsolata-Bold.ttf"
	curl -L "$url_migu" >"$path_tmproot/migu-1m-20150712.zip"
elif type wget >/dev/null 2>&1; then
	wget -O - "$url_inconsolata_r" >"$path_fonts_to_set/Inconsolata-Regular.ttf"
	wget -O - "$url_inconsolata_b" >"$path_fonts_to_set/Inconsolata-Bold.ttf"
	wget -O - "$url_migu" >"$path_tmproot/migu-1m-20150712.zip"
else
	printf 'ERROR: command wget or curl not found.\n' >&2
	exit 1
fi
unzip "$path_tmproot/migu-1m-20150712.zip"
mv "$path_tmproot/migu-1m-20150712/migu-1m-regular.ttf" "$path_fonts_to_set/migu-1m-regular.ttf"
mv "$path_tmproot/migu-1m-20150712/migu-1m-bold.ttf" "$path_fonts_to_set/migu-1m-bold.ttf"

rm -rf "$path_tmproot"
