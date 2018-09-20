#!/bin/sh

set -eu
umask 0022

if [ -d "$HOME/usr/bash-completion" ]; then
	rm -rf "$HOME/usr/bash-completion"
fi
