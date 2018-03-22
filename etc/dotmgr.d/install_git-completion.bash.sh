#!/bin/sh

set -u

url_script="https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash"

if command -v wget > /dev/null 2>&1
then
    wget -O - "$url_script" > "$HOME/.git-completion.bash"
elif command -v curl > /dev/null 2>&1
then
    curl -L "$url_script" > "$HOME/.git-completion.bash"
else
    printf "ERROR: command \"wget\" or \"curl\" not found.\\n" 1>&2
    exit 1
fi

