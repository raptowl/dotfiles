#!/bin/sh

set -u

url_script="https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh"

if command -v wget > /dev/null 2>&1
then
    wget -O - "$url_script" > "$HOME/.git-prompt.sh"
elif command -v curl > /dev/null 2>&1
then
    curl -L "$url_script" > "$HOME/.git-prompt.sh"
else
    printf "ERROR: command \"wget\" or \"curl\" not found.\\n" 1>&2
    exit 1
fi

