#!/bin/sh

set -u
umask 0022

url='cht.sh/:cht.sh'

[ ! -d "$HOME/usr/bin" ] && mkdir -p "$HOME/usr/bin"

cd "$HOME/usr/bin" || exit 1
if type curl > /dev/null 2>&1; then
  curl -L "$url" > './cht.sh' &&
  chmod 755 './cht.sh'
elif type wget > /dev/null 2>&1; then
  wget -O - "$url" > './cht.sh' &&
  chmod 755 './cht.sh'
else
  printf 'ERROR: command curl or wget not found.\n' >&2
fi
