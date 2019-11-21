#!/bin/sh

################################################################
#
# error_exit.sh
#   - output error message and exit with error status
#
# written by raptowl on 2019/11/22
#
################################################################

# $1: exit status
# $2: error message to output to stderr
error_exit() {
  printf '\033[31m[ERROR]\033[0m %s: %s\n' "${0##*/}" "$2" >&2
  exit "$1"
}
