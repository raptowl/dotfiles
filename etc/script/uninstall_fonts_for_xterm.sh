#!/bin/sh

set -eu
umask 0022

path_fonts="$HOME/.local/share/fonts"

rm -f "$path_fonts/Inconsolata-Regular.ttf"
rm -f "$path_fonts/Inconsolata-Bold.ttf"
rm -f "$path_fonts/migu-1m-regular.ttf"
rm -f "$path_fonts/migu-1m-bold.ttf"

