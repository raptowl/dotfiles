#!/bin/sh

set -e -u
umask 0022

# about ~
path_dst="$HOME"
path_src="$HOME/.dotfiles"

ls -1 -A "$path_src" |
	grep -v -e '^\.config$' \
		-e '\.git$' \
		-e '\.gitignore$' \
		-e '^etc$' |
	sed -e "s%^%$path_dst/%" |
	xargs file |
	awk -F ':' '$2 !~ "symbolic link to '"$path_src"'" && $2 !~ "cannot open" { print $0; }' |
	cut -d ':' -f 1 |
	sed -e "s%^\(.*\)\$%mv '\1' '\1.dotold'%" |
	sh -s "$@"

ls -1 -A "$path_src" |
	grep -v -e '^\.config$' \
		-e '\.git$' \
		-e '\.gitignore$' \
		-e '^etc$' |
	sed -e "s%^%$path_dst/%" |
	xargs file |
	awk -F ':' '$2 !~ "symbolic link to '"$path_src"'" { print $0; }' |
	cut -d ':' -f 1 |
	sed -e "s%^$path_dst/\(.*\)\$%ln -s '$path_src/\1' '$path_dst/\1'%" |
	sh -s "$@"

# about ~/.config
path_dst="$HOME/.config"
path_src="$HOME/.dotfiles/.config"

if [ ! -d "$path_dst" ]; then
	mkdir -p "$path_dst"
fi

ls -1 -A "$path_src" |
	sed -e "s%^%$path_dst/%" |
	xargs file |
	awk -F ':' '$2 !~ "symbolic link to '"$path_src"'" && $2 !~ "cannot open" { print $0; }' |
	cut -d ':' -f 1 |
	sed -e "s%^\(.*\)\$%mv '\1' '\1.dotold'%" |
	sh -s "$@"

ls -1 -A "$path_src" |
	sed -e "s%^%$path_dst/%" |
	xargs file |
	awk -F ':' '$2 !~ "symbolic link to '"$path_src"'" { print $0; }' |
	cut -d ':' -f 1 |
	sed -e "s%^$path_dst/\(.*\)\$%ln -s '$path_src/\1' '$path_dst/\1'%" |
	sh -s "$@"
