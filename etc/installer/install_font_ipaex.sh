#!/bin/sh

set -u
umask 0022

# path to the temporary directory
path_tmproot="$HOME/tmp$$"

# path to install fonts
path_fonts_to_set="$HOME/.local/share/fonts"

# url of 'ipaex' font archive
url_fontarch='ipafont.ipa.go.jp/old/ipaexfont/IPAexfont00201.php'

# remove tmporary directory
remove_tmproot() {
  [ -d "$path_tmproot" ] && rm -rf "$path_tmproot"
}
trap 'remove_tmproot' 1 2 3 15

# output error and exit if command 'unzip' is not installed
if ! type unzip >/dev/null 2>&1; then
  printf 'ERROR: command unzip not found.\n' >&2
  exit 1
fi

# make a temporary root directory
[ ! -d "$path_tmproot" ] && mkdir -p "$path_tmproot"

# change the working directory to the temporary root directory
cd "$path_tmproot" || exit

if type curl >/dev/null 2>&1; then
# if command 'curl' is installed, download the archive of 'ipaex' using 'curl'
  curl -L "$url_fontarch" >'./archives.zip'
  unzip './archives.zip'
  mv -fv './IPAexfont00201/'*'.ttf' "$path_fonts_to_set"
elif type wget >/dev/null 2>&1; then
# if command 'wget' is installed, download the archive of 'ipaex' using 'wget'
  wget -O - "$url_fontarch" >'./archives.zip'
  unzip './archives.zip'
  mv -fv './IPAexfont00201/'*'.ttf' "$path_fonts_to_set"
else
# if any commands is not installed, output error message and exit
  printf 'ERROR: command git, wget or curl not found.\n' >&2
  exit 1
fi

# make a directory which indicates "$path_fonts_to_set" to install fonts, and change 
[ ! -d "$path_fonts_to_set" ] && mkdir -p "$path_fonts_to_set"

# remove tmporary directory
remove_tmproot
