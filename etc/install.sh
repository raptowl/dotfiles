#!/bin/sh

# initializing
set -u
umask 0022

# set variables
url_gitrepo='https://github.com/raptowl/dotfiles.git'  # the url which indicates the git repository on github
url_tarball='github.com/raptowl/dotfiles/archive/master.tar.gz'  # the url which indicates the tar archive of this repository

# set environment variables
DOTFILES_LOC="$(pwd)/.dotfiles"  # the path which indicates the dotfiles directory
export DOTFILES_LOC

# main routine
if type git > /dev/null 2>&1; then
	git clone "$url_gitrepo" "$DOTFILES_LOC"
elif type curl > /dev/null 2>&1; then
	curl -L "$url_tarball" | tar xzv
	mv -fv "$HOME/dotfiles-master" "$DOTFILES_LOC"
elif type wget > /dev/null 2>&1; then
	wget -O - "$url_tarball" | tar xzv
	mv -fv "$HOME/dotfiles-master" "$DOTFILES_LOC"
else
	printf 'ERROR: command git wget or curl not found.\n' >&2
	exit 1
fi

# setup the .dotfiles_loc file
sed -e 's%^DOTFILES_LOC=$%DOTFILES_LOC='"$DOTFILES_LOC"'%' < "$DOTFILES_LOC/etc/template/dotfiles_loc.sh" > "$HOME/.dotfiles_loc"

# deploy configuration files
"$DOTFILES_LOC/bin/dotutil" link
