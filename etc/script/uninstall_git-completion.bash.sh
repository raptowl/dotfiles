#!/bin/sh

set -e -u
umask 0022

if [ -f "$HOME/.git-completion.bash" ]; then
	rm -rf "$HOME/.git-completion.bash"
fi
