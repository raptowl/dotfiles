#!/bin/sh

set -u

if [ $# -eq 0 ]
then
    cat 1>&2 << _EOT_
dpmgr.sh is a display output manager script for X Window System.
Please run "dpmgr.sh --help" to show usage of this command.
_EOT_
    exit 1
elif [ "$1" = "--help" ]
then
    cat << _EOT_
usage: dpmgr.sh [--help] <command>

[option]
--help
    show usage of this command

<command>
_EOT_
fi

