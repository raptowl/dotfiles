#!/bin/sh

set -u

if [ $# -eq 0 ]
then
    cat 1>&2 << EOF
dpmgr.sh is a display output manager script for X Window System.
Please run "dpmgr.sh --help" to show usage of this command.
EOF
    exit 1
elif [ "$1" = "--help" ]
    cat << EOF
dpmgr.sh [--help] <command>

<command>
EOF
then
    :
fi

