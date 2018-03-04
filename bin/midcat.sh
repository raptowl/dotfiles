#!/bin/sh

if [ $# -le 2 ]
then
    echo "Error: the number of arguments is incorrect." 1>&2
    exit 1
fi

startline=$1
endline=$2
shift 2

cat $* | head -n $endline | tail -n `expr $endline - $startline + 1`

