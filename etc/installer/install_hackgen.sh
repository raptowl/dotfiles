#!/bin/sh

set -u
umask 0022

# path to the temporary directory
path_tmproot="$HOME/tmp$$"

# path to install fonts
path_fonts_to_set="$HOME/.local/share/fonts"

# url of 'hackgen' github repository
url_gitrepo='https://github.com/yuru7/HackGen.git'

# url of 'hackgen' github archive
url_gitarcv='github.com/yuru7/HackGen/archive/master.tar.gz'

# remove tmporary directory
remove_tmproot() {
  [ -d "$path_tmproot" ] && rm -rf "$path_tmproot"
}
trap 'remove_tmproot' 1 2 3 15

# make a temporary root directory
[ ! -d "$path_tmproot" ] && mkdir -p "$path_tmproot"

# change the working directory to the temporary root directory
cd "$path_tmproot" || exit

if type git >/dev/null 2>&1; then
# if command 'git' is installed, get the clone of 'hackgen' github repository
  git clone "$url_gitrepo"
  mv -fv './HackGen/build/'*'.ttf' "$path_fonts_to_set"
elif type curl >/dev/null 2>&1; then
# if command 'curl' is installed, download the archive of 'hackgen' github repository using 'curl'
  curl -L "$url_gitarcv" >'./master.tar.gz'
  tar xvf './master.tar.gz'
  mv -fv './HackGen-master/build/'*'.ttf' "$path_fonts_to_set"
elif type wget >/dev/null 2>&1; then
# if command 'wget' is installed, download the arvhice of 'hackgen' github repository using 'wget'
  wget -O - "$url_gitarcv" >'./master.tar.gz'
  tar xvf './master.tar.gz'
  mv -fv './HackGen-master/build/'*'.ttf' "$path_fonts_to_set"
else
# if any commands is not installed, output error message and exit
  printf 'ERROR: command git, wget or curl not found.\n' >&2
  exit 1
fi

# make a directory which indicates "$path_fonts_to_set" to install fonts, and change 
[ ! -d "$path_fonts_to_set" ] && mkdir -p "$path_fonts_to_set"

# remove tmporary directory
remove_tmproot
