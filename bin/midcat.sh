#!/bin/sh

############################################################
# PREPROCESSING
############################################################

set -u
. $DOTFILES/etc/lib.sh

############################################################
# VARIABLES, FUNCTIONS
############################################################

# the number of start line
startline=$1

# the number of end line
endline=$2
shift 2

# error code of the whole of this command
return_stat=0

############################################################
# MAIN ROUTINE
############################################################

if [ $# -le 2 ]
then
    Msg_err "the number of arguments is incorrect.\n" 1>&2
    return_stat=1
    exit $return_stat
fi

cat $* | \
head -n $endline | \
tail -n $(expr $endline - $startline + 1)
return_stat=$?

exit $return_stat

