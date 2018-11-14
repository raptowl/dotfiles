#!/bin/sh

set -e -u
umask 0022

# about ~
path_dst="$HOME"
path_src="$HOME/.dotfiles"

ls -1 -a "$path_dst" |
	sed -e "s%^%$path_dst/%" |
	xargs file |
	awk -F ':' '$2 ~ symbolic link to "'"$path_src"'" { print; }' |
	cut -d ':' -f 1 |
	sed -e "s/^\(.*\)\$/rm '&'/" |
	sh -s -v

ls -1 -a "$path_dst" |
	grep -e '\.dotold$' |
	sed -e "s%^%$path_dst/%" |
	sed -e "s/^\(.*\)\.dotold\$/mv '\1.dotold' '\1'/" |
	sh -s -v

# about ~/.config
path_dst="$HOME/.config"
path_src="$HOME/.dotfiles/.config"

ls -1 -a "$path_dst" |
	sed -e "s%^%$path_dst/%" |
	xargs file |
	awk -F ':' '$2 ~ symbolic link to "'"$path_src"'" { print; }' |
	cut -d ':' -f 1 |
	sed -e "s/^\(.*\)\$/rm '&'/" |
	sh -s -v

ls -1 -a "$path_dst" |
	grep -e '\.dotold$' |
	sed -e "s%^%$path_dst/%" |
	sed -e "s/^\(.*\)\.dotold\$/mv '\1.dotold' '\1'/" |
	sh -s -v

if [ -z "$(ls -1 -a "$path_dst")" ]; then
	rmdir "$path_dst"
fi
