#!/bin/sh

set -u

if [ "$1" = "input" ] || [ "$1" = "i" ]; then
    if command -v xclip > /dev/null 2>&1; then
        xclip -i -selection "clipboard"
    elif command -v xsel > /dev/null 2>&1; then
        xsel -i -b
    elif command -v pbcopy > /dev/null 2>&1; then
        pbcopy
    else
        printf "ERROR: command \"xclip\", \"xsel\" or \"pbcopy\" not found.\\n" 1>&2
        exit 1
    fi
elif [ "$1" = "output" ] || [ "$1" = "o" ]; then
    if command -v xclip > /dev/null 2>&1; then
        xclip -o -selection "clipboard"
    elif command -v xsel > /dev/null 2>&1; then
        xsel -o -b
    elif command -v pbpaste > /dev/null 2>&1; then
        pbpaste
    else
        printf "ERROR: command \"xclip\", \"xsel\" or \"pbcopy\" not found.\\n" 1>&2
        exit 1
    fi
elif [ "$1" = "clear" ] || [ "$1" = "c" ]; then
    if command -v xclip > /dev/null 2>&1; then
        : | xclip -i -selection "clipboard"
    elif command -v xsel > /dev/null 2>&1; then
        xsel -c -b
    elif command -v pbcopy > /dev/null 2>&1; then
        : | pbcopy
    else
        printf "ERROR: command \"xclip\", \"xsel\" or \"pbcopy\" not found.\\n" 1>&2
        exit 1
    fi
else
    printf "ERROR: command %s is not defined.\\n" "$1" 1>&2
    exit 1
fi

