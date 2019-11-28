#!/bin/sh

################################################################
#
# list_files_with_dot.sh
#   - list up files including dotfiles in a directory
#
# written by raptowl on 2019/11/28
#
################################################################

# $1: (optional) a directory in which you want to list up files
list_files_with_dot() {
  printf '%s\n' "${1:-./}"* "${1:-./}".* |
    grep -v \
      -e '/\.$' \
      -e '/\.\.$' |
    sed -e "s%^%${1:-}:%" |
    sed -e 's%^:\./%%' |
    sed -e "s%^${1:-}:%%"
}
