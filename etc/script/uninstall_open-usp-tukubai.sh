#!/bin/sh

set -e -u
umask 0022

if [ -d "$HOME/usr/shellshoccar" ]; then
	rm -rf "$HOME/usr/shellshoccar"
fi
