#!/bin/sh

set -eu
umask 0022

if [ -d "$HOME/usr/shellshoccar" ]; then
	rm -rf "$HOME/usr/shellshoccar"
fi

