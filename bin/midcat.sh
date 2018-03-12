#!/bin/sh

set -u

if [ $# -le 2 ]
then
    printf "ERROR: the number of arguments is incorrect.\\n" 1>&2
    exit 1
fi

# the number of start line
startline=$1

# the number of end line
endline=$2

shift 2

cat "$@" | \
head -n "$endline" | \
tail -n "$(expr "$endline" - "$startline" + 1)"

