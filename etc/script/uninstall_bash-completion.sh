#!/bin/sh

set -e -u
umask 0022

if [ -d "$HOME/usr/bash-completion" ]; then
	rm -rf "$HOME/usr/bash-completion"
fi
