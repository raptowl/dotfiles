#!/bin/sh

set -u

if [ -f "$HOME/.git-completion.bash" ]; then
    rm -rf "$HOME/.git-completion.bash"
fi

