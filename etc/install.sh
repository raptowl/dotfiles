#!/bin/sh

# initializing
set -u
umask 0022

# set variables
url_gitrepo='https://github.com/raptowl/dotfiles.git'  # the url which indicates the git repository on github
url_tarball='github.com/raptowl/dotfiles/archive/master.tar.gz'  # the url which indicates the tar archive of this repository

# main routine
cd "$HOME" || exit 1
if type git > /dev/null 2>&1; then
	git clone "$url_gitrepo" "$HOME/.dotfiles"
elif type curl > /dev/null 2>&1; then
	curl -L "$url_tarball" | tar xzv
	mv -fv "$HOME/dotfiles-master" "$HOME/.dotfiles"
elif type wget > /dev/null 2>&1; then
	wget -O - "$url_tarball" | tar xzv
	mv -fv "$HOME/dotfiles-master" "$HOME/.dotfiles"
else
	printf 'ERROR: command git wget or curl not found.\n' >&2
	exit 1
fi

# deploy configuration files
"$HOME/.dotfiles/bin/dotutil" link | sh