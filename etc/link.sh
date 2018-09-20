#!/bin/sh

set -eu
umask 0022

# the path indicates the dotfiles directory
path_dotfiles="$HOME/.dotfiles"

# get the name list of files to put symbolic links to $HOME
for i in $(find "$path_dotfiles" -maxdepth 1 | \
	grep -v -e "$path_dotfiles\$" \
		-e '.config$' \
		-e 'etc$' \
		-e '.gitignore$' \
		-e '.git$' | \
	sed -e "s%$path_dotfiles%$HOME%" | \
	xargs file | \
	grep -v -e 'symbolic' | \
	grep -v -e "$path_dotfiles" | \
	sed -e "s%$HOME/%%" \
		-e 's/: .*//')
do
	# if there is a original dotfile, rename it
	if [ -f "$HOME/$i" ] || [ -d "$HOME/$i" ]; then
		mv -fv "$HOME/$i" "$HOME/$i.dotold"
	fi

	# put a symbolic link
	ln -fsv "$path_dotfiles/$i" "$HOME/$i"
done

# get the name list of files in .config to put symbolic links to $HOME/.config
if ! [ -d "$HOME/.config" ]; then
	mkdir "$HOME/.config"
fi

for i in $(find "$path_dotfiles/.config" -maxdepth 1 | \
	grep -v -e "$path_dotfiles/.config\$" | \
	sed -e "s%$path_dotfiles/.config%$HOME/.config%" | \
	xargs file | \
	grep -v -e 'symbolic' | \
	grep -v -e "$path_dotfiles/.config" | \
	sed -e "s%$HOME/.config/%%" \
		-e 's/: .*//')
do
	# if there is a original dotfile, rename it
	if [ -f "$HOME/.config/$i" ] || [ -d "$HOME/.config/$i" ]; then
		mv -fv "$HOME/.config/$i" "$HOME/.config/$i.dotold"
	fi

	# put a symbolic link
	ln -fsv "$path_dotfiles/.config/$i" "$HOME/.config/$i"
done
