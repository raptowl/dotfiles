#!/bin/sh

set -e -u
umask 0022

# about ~
path_dst="$HOME"
path_src="$HOME/.dotfiles"

ls -1 -A "$path_dst" |
	sed -e "s%^%$path_dst/%" |
	xargs file |
	awk -F ':' '$2 ~ "symbolic link to '"$path_src"'" { print $0; }' |
	cut -d ':' -f 1 |
	sed -e "s%^\(.*\)\$%rm '\1'%" |
	sh -s "$@"

ls -1 -A "$path_dst" |
	grep -e '\.dotold$' |
	sed -e "s%^\(.*\)\.dotold\$%mv '$path_dst/\1.dotold' '$path_dst/\1'%" |
	sh -s "$@"

# about ~/.config
path_dst="$HOME/.config"
path_src="$HOME/.dotfiles/.config"

ls -1 -A "$path_dst" |
	sed -e "s%^%$path_dst/%" |
	xargs file |
	awk -F ':' '$2 ~ "symbolic link to '"$path_src"'" { print $0; }' |
	cut -d ':' -f 1 |
	sed -e "s%^\(.*\)\$%rm '\1'%" |
	sh -s "$@"

ls -1 -A "$path_dst" |
	grep -e '\.dotold$' |
	sed -e "s%^\(.*\)\.dotold\$%mv '$path_dst/\1.dotold' '$path_dst/\1'%" |
	sh -s "$@"

if [ -z "$(ls -1 -A "$path_dst")" ]; then
	rmdir "$path_dst"
fi
