#!/bin/sh
# >> parse_and_print_usage[description]
# Short description here ...
# ...
# << parse_and_print_usage[description]

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
#. "$DOTFILES_DIR/lib/io/logging_error.sh"

# catch signals
#trap '' HUP INT QUIT TERM

################################################################
# argument parsing
################################################################

# print the usage and exit
case "$# ${1:-}" in
  '1 -h'|'1 --help')
    #parse_and_print_usage
    :
    ;;
esac

################################################################
# main routine
################################################################

