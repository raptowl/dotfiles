#!/bin/sh

################################################################
#
# check_dir_empty.sh
#   - check if a directory is empty and return a status code
#
# written by raptowl on 2019/11/30
#
################################################################

# $1: (optional) a directory which you want to check
check_dir_empty() {
  printf '%s\n' "${1:-./}"* "${1:-./}".* |
    grep -v \
      -e '/\*$' \
      -e '/\.$' \
      -e '/\.\.$' |
    grep -e '^' > /dev/null 2>&1 && return 1
  return 0  # return 0 if the directory is empty
}
