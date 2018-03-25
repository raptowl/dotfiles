#!/bin/sh

set -u

if [ -f "$HOME/.git-completion.bash" ]; then
    rm -fv "$HOME/.git-completion.bash"
fi

