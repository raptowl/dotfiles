#!/bin/sh

############################################################
# VARIABLES, FUNCTIONS
############################################################

set -u
. $DOTFILES/etc/lib.sh

# the number of start line
startline=$1
# the number of end line
endline=$2
shift 2

############################################################
# MAIN ROUTINE
############################################################

if [ $# -le 2 ]
then
    printf "Error: the number of arguments is incorrect.\n" 1>&2
    exit 1
fi

cat $* | \
head -n $endline | \
tail -n $(expr $endline - $startline + 1)

