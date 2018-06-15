#!/bin/sh

set -u
umask 0022
PATH='/usr/bin:/bin'
IFS=$(printf ' \t\n_'); IFS=${IFS%_}
export IFS LC_ALL=C LANG=C PATH

# check the number of arguments
if [ $# -ne 1 ]; then
    printf "ERROR: the number of arguments is incorrect.\\n" 1>&2
    exit 1
fi

# main routine
if [ "$1" = "i" ]; then
    if type xsel > /dev/null 2>&1; then
        xsel -i -b
    elif type xclip > /dev/null 2>&1; then
        xclip -i -selection "clipboard"
    elif type pbcopy > /dev/null 2>&1; then
        pbcopy
    else
        printf "ERROR: command \"xsel\", \"xclip\" or \"pbcopy\" not found.\\n" 1>&2
        exit 1
    fi
elif [ "$1" = "o" ]; then
    if type xsel > /dev/null 2>&1; then
        xsel -o -b
    elif type xclip > /dev/null 2>&1; then
        xclip -o -selection "clipboard"
    elif type pbpaste > /dev/null 2>&1; then
        pbpaste
    else
        printf "ERROR: command \"xsel\", \"xclip\" or \"pbcopy\" not found.\\n" 1>&2
        exit 1
    fi
elif [ "$1" = "c" ]; then
    if type xsel > /dev/null 2>&1; then
        xsel -c -b
    elif type xclip > /dev/null 2>&1; then
        : | xclip -i -selection "clipboard"
    elif type pbcopy > /dev/null 2>&1; then
        : | pbcopy
    else
        printf "ERROR: command \"xsel\", \"xclip\" or \"pbcopy\" not found.\\n" 1>&2
        exit 1
    fi
else
    printf "ERROR: operation %s is not defined.\\n" "$1" 1>&2
    exit 1
fi

