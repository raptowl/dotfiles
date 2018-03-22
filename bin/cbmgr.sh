#!/bin/sh

set -u

if [ $# -eq 0 ]
then
    cat 1>&2 << _EOT_
cbmgr.sh is a clipboard manager script for CLI environment of UNIX like system.
Please run "clpmgr.sh --help" to show the usage of this command.
_EOT_
    exit 1
elif [ "$1" = "--help" ]
then
    cat << _EOT_
usage: cbmgr.sh [--help] <command>

[option]
--help
    show usage of this command

<command>
input | i
    write the data to clipboard from standard input

output | o
    write the data to standard output from clipboard

clear | c
    clear up clipboard
_EOT_
elif [ "$1" = "input" ] || [ "$1" = "i" ]
then
    if command -v xclip > /dev/null 2>&1
    then
        xclip -i -selection "clipboard"
    elif command -v xsel > /dev/null 2>&1
    then
        xsel -i -b
    elif command -v pbcopy > /dev/null 2>&1
    then
        pbcopy
    else
        printf "ERROR: at least a command of \"xclip\" or \"xsel\" or \"pbcopy\" is necessary.\\n" 1>&2
        exit 1
    fi
elif [ "$1" = "output" ] || [ "$1" = "o" ]
then
    if command -v xclip > /dev/null 2>&1
    then
        xclip -o -selection "clipboard"
    elif command -v xsel > /dev/null 2>&1
    then
        xsel -o -b
    elif command -v pbpaste > /dev/null 2>&1
    then
        pbpaste
    else
        printf "ERROR: at least a command of \"xclip\" or \"xsel\" or \"pbpaste\" is necessary.\\n" 1>&2
        exit 1
    fi
elif [ "$1" = "clear" ] || [ "$1" = "c" ]
then
    if command -v xclip > /dev/null 2>&1
    then
        : | xclip -i -selection "clipboard"
    elif command -v xsel > /dev/null 2>&1
    then
        xsel -c -b
    elif command -v pbcopy > /dev/null 2>&1
    then
        : | pbcopy
    else
        printf "ERROR: at least a command of \"xclip\" or \"xsel\" or \"pbcopy\" is necessary.\\n" 1>&2
        exit 1
    fi
else
    printf "ERROR: command %s is not defined.\\n" "$1" 1>&2
    exit 1
fi

