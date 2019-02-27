#!/bin/sh

set -u
umask 0022

# path to the temporary directory
path_tmproot="$HOME/tmp$$"

# path to install fonts
path_fonts_to_set="$HOME/.local/share/fonts"

# url of font 'inconsolata regular'
url_inconsolata_r='github.com/google/fonts/raw/master/ofl/inconsolata/Inconsolata-Regular.ttf'

# url of font 'inconsolata bold'
url_inconsolata_b='github.com/google/fonts/raw/master/ofl/inconsolata/Inconsolata-Bold.ttf'

# url of font 'migu'
url_migu='ja.osdn.jp/projects/mix-mplus-ipa/downloads/63545/migu-1m-20150712.zip'

# remove tmporary directory
remove_tmproot() {
	if [ -d "$path_tmproot" ]; then
		rm -rf "$path_tmproot"
	fi
}
trap 'remove_tmproot' 1 2 3 15

# output error and exit if command 'unzip' is not installed
if ! type unzip >/dev/null 2>&1; then
	printf 'ERROR: command unzip not found.\n' >&2
	exit 1
fi

# make a directory to install fonts
if [ ! -d "$path_fonts_to_set" ]; then
	mkdir -p "$path_fonts_to_set"
fi

# main routine
mkdir -p "$path_tmproot"
cd "$path_tmproot" || exit 1
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

# remove tmporary directory
remove_tmproot
