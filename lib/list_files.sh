#!/bin/sh

################################################################
#
# list_files.sh
#   - list up files in a directory
#
# written by raptowl on 2019/11/28
#
################################################################

# $1: (optional) a directory in which you want to list up files
list_files() {
  printf '%s\n' "${1:-./}"* |
    sed -e "s%^%${1:-}:%" |
    sed -e 's%^:\./%%' |
    sed -e "s%^${1:-}:%%"
}
