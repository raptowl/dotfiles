#!/bin/sh

set -u

find "$HOME/.fonts" -maxdepth 1 |
grep -e "Ricty" |
xargs rm

