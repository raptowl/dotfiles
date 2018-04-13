#!/bin/sh

set -u

if [ -f "$HOME/.git-prompt.sh" ]; then
    rm -rf "$HOME/.git-prompt.sh"
fi

