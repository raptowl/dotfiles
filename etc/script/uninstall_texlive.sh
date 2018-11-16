#!/bin/sh

set -e -u
umask 0022

if [ -d "$HOME/usr/texlive" ]; then
	rm -rf "$HOME/usr/texlive"
fi
