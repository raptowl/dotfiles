#!/bin/sh

set -u

if [ -f "$HOME/.git-prompt.sh" ]; then
    rm -fv "$HOME/.git-prompt.sh"
fi

