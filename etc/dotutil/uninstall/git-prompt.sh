#!/bin/sh

################################################################
#
# git-prompt.sh
#   - uninstaller of git-prompt.sh
#
# written by raptowl on 2019/11/26
#
################################################################

################################################################
# preprocessing
################################################################

# initialize shell environment
set -u
umask 0022
LC_ALL=C
type command > /dev/null 2>&1 && type getconf > /dev/null 2>&1 &&
PATH="$(command -p getconf PATH)${PATH+:}${PATH-}"
UNIX_STD=2003
export LC_ALL PATH UNIX_STD

# load and define functions
#. "$HOME/.dotfiles/lib/xxx.sh"

usage() {
  cat <<_EOT_ >&2
Usage: ${0##*/} [-h | --help]

uninstall git-prompt.sh

option:
  -h | --help: print out the usage to stderr
_EOT_
  exit 1
}

# catch signals
#trap '' 1 2 3 15

################################################################
# argument parsing
################################################################

# print the usage and exit
case "$# ${1:-}" in
  '1 -h'|'1 --help')
    usage
    ;;
esac

################################################################
# main routine
################################################################

# define variables
cd "$HOME/usr/local" || exit 1
rm './git-prompt.sh'
