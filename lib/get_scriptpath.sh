#!/bin/sh

################################################################
#
# get_scriptpath.sh
#   - get the path where the script exists
#
# written by raptowl on 2019/11/26
#
################################################################

# (no arguments)
get_scriptpath() {
  l_scriptpath="${0%/*}/"
  [ "_$l_scriptpath" = "_$0/" ] && l_scriptpath='./'
  cd "$l_scriptpath" || exit 1
  pwd

  unset -v l_scriptpath
}
