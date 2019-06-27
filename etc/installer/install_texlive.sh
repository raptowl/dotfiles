#!/bin/sh

set -u
umask 0022

# path to the temporary directory
path_tmproot="$HOME/tmp$$"

# url of the archive of texlive
url_texlive='mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz'

# url of the repository of 'tlmgr'
url_texrepo='http://ftp.jaist.ac.jp/pub/CTAN/systems/texlive/tlnet'

# remove the temporary directory
remove_tmproot() {
  if [ -d "$path_tmproot" ]; then
    rm -rf "$path_tmproot"
  fi
}
trap 'remove_tmproot' 1 2 3 15

# output error and exit if command 'wget' is not installed
if ! type wget >/dev/null 2>&1; then
  printf 'ERROR: command wget not found.\n' >&2
  exit 1
fi

# make a directory to install local applications
if [ ! -d "$HOME/usr" ]; then
  mkdir -p "$HOME/usr"
fi

# main routine
mkdir -p "$path_tmproot"
cd "$path_tmproot" || exit 1

if type curl >/dev/null 2>&1; then
  curl -L "$url_texlive" |
    tar xzv
elif type wget >/dev/null 2>&1; then
  wget -O - "$url_texlive" |
    tar xzv
fi
cd "$(find "$path_tmproot" -maxdepth 1 |
  grep -e "install-tl")" || exit 1
printf 'I\n' |
  TEXLIVE_INSTALL_PREFIX="$HOME/usr/texlive" ./install-tl --repository "$url_texrepo"

# remove the temporary directory
remove_tmproot
