#!/bin/sh

set -eu
umask 0022

find "$HOME/.fonts" -maxdepth 1 | \
	grep -e 'Ricty' | \
	xargs rm -rf

