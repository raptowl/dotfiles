#!/bin/sh

################################################################
#
# error.sh
#   - output error message
#
# written by raptowl on 2019/11/26
#
################################################################

# $1: error message to output to stderr
error() {
  printf '\033[31m[ERROR]\033[0m %s: %s\n' "${0##*/}" "$1" >&2
}
