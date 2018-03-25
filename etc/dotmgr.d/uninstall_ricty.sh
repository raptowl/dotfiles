#!/bin/sh

set -u

rm -fv "$HOME/.fonts/Ricty-*.ttf"
if [ "$(find "$HOME/.fonts" -maxdepth 1 |
        grep -v -e "^$HOME/\\.fonts\$")" = "" ]; then
    rmdir "$HOME/.fonts"
fi

