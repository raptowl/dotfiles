#!/bin/sh

set -u
umask 0022

# about ~
path_dst="$HOME"
path_src="$HOME/.dotfiles"

# rename dotfiles which has already existed in ~
cd "$path_src" || exit 1
for files in * .*; do printf '%s\n' "$files"; done |
	grep -v \
		-e '^\.$' \
		-e '^\.\.$' \
		-e '^\.config$' \
		-e '^\.git$' \
		-e '^\.gitignore$' \
		-e '^etc$' \
		-e '^LICENSE$' \
		-e '^README.md$' |
	sed -e "s%^%$path_dst/%" |
	xargs file |
	sed -e 's/:  */:/' |
	awk -F ':' '! match($2, "symbolic link to.*'"$path_src"'") && ! match($2, "cannot open.*") { print $1; }' |
	sed -e "s%\(.*\)%mv '\1' '\1.dotold'%"

# put links from ~/.dotfiles to ~
for files in * .*; do printf '%s\n' "$files"; done |
	grep -v \
		-e '^\.$' \
		-e '^\.\.$' \
		-e '^\.config$' \
		-e '^\.git$' \
		-e '^\.gitignore$' \
		-e '^\etc$' \
		-e '^LICENSE$' \
		-e '^README.md$' |
	sed -e "s%^%$path_dst/%" |
	xargs file |
	sed -e 's/:  */:/' |
	awk -F ':' '! match($2, "symbolic link to.*'"$path_src"'") { print $1; }' |
	sed -e "s%^$path_dst/\(.*\)\$%ln -fs '$path_src/\1' '$path_dst/\1'%"

# about ~/.config
path_dst="$HOME/.config"
path_src="$HOME/.dotfiles/.config"

# make a directory which points ~/.config if it does not exist
[ ! -d "$path_dst" ] && mkdir -p "$path_dst"

# rename dotfiles which has already existed in ~/.config
cd "$path_src" || exit 1
for files in * .*; do printf '%s\n' "$files"; done |
	grep -v \
		-e '^\.$' \
		-e '^\.\.$' |
	sed -e "s%^%$path_dst/%" |
	xargs file |
	sed -e 's/:  */:/' |
	awk -F ':' '! match($2, "symbolic link to.*'"$path_src"'") && ! match($2, "cannot open.*") { print $1; }' |
	sed -e "s%\(.*\)%mv '\1' '\1.dotold'%"

# put links from ~/.dotfiles/.config to ~/.config
for files in * .*; do printf '%s\n' "$files"; done |
	grep -v \
		-e '^\.$' \
		-e '^\.\.$' |
	sed -e "s%^%$path_dst/%" |
	xargs file |
	sed -e 's/:  */:/' |
	awk -F ':' '! match($2, "symbolic link to.*'"$path_src"'") { print $1; }' |
	sed -e "s%^$path_dst/\(.*\)\$%ln -fs '$path_src/\1' '$path_dst/\1'%"
