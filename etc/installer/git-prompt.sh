#!/bin/sh

set -u
umask 0022

url='raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh'

[ ! -d "$HOME/usr/local" ] && mkdir -p "$HOME/usr/local"

cd "$HOME/usr/local" || exit 1
if type curl > /dev/null 2>&1; then
  curl -L "$url" > './git-prompt.sh'
elif type wget > /dev/null 2>&1; then
  wget -O - "$url" > './git-prompt.sh'
else
  printf 'ERROR: command curl or wget not found.\n' >&2
fi
