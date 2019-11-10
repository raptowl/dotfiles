#!/bin/sh

set -u
umask 0022

# about ~
path_dst="$HOME"
path_src="$HOME/.dotfiles"

# remove links at ~
cd "$path_dst" || exit 1
for files in * .*; do printf '%s\n' "$files"; done |
	sed -e "s%^%$path_dst/%" |
	xargs file |
	sed -e 's/:  */:/' |
	awk -F ':' 'match($2, "symbolic link to.*'"$path_src"'") { print $1; }' |
	sed -e "s%^.*\$%rm '&'%"

# rename dotfiles which were original
for files in * .*; do printf '%s\n' "$files"; done |
	grep -e '\.dotold$' |
	sed -e "s%^\(.*\)\.dotold\$%mv '$path_dst/\1.dotold' '$path_dst/\1'%"

# about ~/.config
path_dst="$HOME/.config"
path_src="$HOME/.dotfiles/.config"

# remove links at ~/.config
cd "$path_dst" || exit 1
for files in * .*; do printf '%s\n' "$files"; done |
	sed -e "s%^%$path_dst/%" |
	xargs file |
	sed -e 's/:  */:/' |
	awk -F ':' 'match($2, "symbolic link to.*'"$path_src"'") { print $1; }' |
	sed -e "s%^.*\$%rm '&'%"

# rename dotfiles which were original
for files in * .*; do printf '%s\n' "$files"; done |
	grep -e '\.dotold$' |
	sed -e "s%^\(.*\)\.dotold\$%mv '$path_dst/\1.dotold' '$path_dst/\1'%"
