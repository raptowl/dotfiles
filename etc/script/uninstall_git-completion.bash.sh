#!/bin/sh

set -eu
umask 0022

if [ -f "$HOME/.git-completion.bash" ]; then
	rm -rf "$HOME/.git-completion.bash"
fi
