#!/bin/sh

set -e -u
umask 0022

# about ~
path_dst="$HOME"
path_src="$HOME/.dotfiles"

{
	ls -1 -a "$path_src" |
		grep -v -e '^\.$' \
			-e '^\.\.$' \
			-e '^\.config$' \
			-e '^etc$' \
			-e '^\.gitignore$' \
			-e '^\.git$'
	ls -1 -a "$path_dst"
} |
	sort |
	uniq -d |
	sed -e "s%^\(.*\)\$%mv '$path_dst/&' '$path_dst/&.dotold'%" |
	sh -s -v

ls -1 -a "$path_src" |
	grep -v -e '^\.$' \
		-e '^\.\.$' \
		-e '^\.config$' \
		-e '^etc$' \
		-e '^\.gitignore$' \
		-e '^\.git$' |
	sed -e "s%^\(.*\)\$%ln -s '$path_src/&' '$path_dst/&'%" |
	sh -s -v

# about ~/.config
path_dst="$HOME/.config"
path_src="$HOME/.dotfiles/.config"

if [ ! -d "$path_dst" ]; then
	mkdir "$path_dst"
fi

{
	ls -1 -a "$path_src" |
		grep -v -e '^\.$' \
			-e '^\.\.$'
	ls -1 -a "$path_dst"
} |
	sort |
	uniq -d |
	sed -e "s%^\(.*\)\$%mv '$path_dst/&' '$path_dst/&.dotold'%" |
	sh -s -v

ls -1 -a "$path_src" |
	grep -v -e '^\.$' \
		-e '^\.\.$' |
	sed -e "s%^\(.*\)\$%ln -s '$path_src/&' '$path_dst/&'%" |
	sh -s -v
