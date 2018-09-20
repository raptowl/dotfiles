#!/bin/sh

set -eu
umask 0022

# the path indicates the dotfiles directory
path_dotfiles="$HOME/.dotfiles"

# the url indicates the git repository on github
url_gitrepo='https://github.com/raptowl/dotfiles.git'

# the url indicates the tar archive of this repository
url_tarball='github.com/raptowl/dotfiles/archive/master.tar.gz'

cd "$HOME"
if type git > /dev/null 2>&1; then
	git clone "$url_gitrepo" "$path_dotfiles"
elif type wget > /dev/null 2>&1; then
	wget -O - "$url_tarball" | \
		tar xzv && \
	mv -f "$HOME/dotfiles-master" "$path_dotfiles"
elif type curl > /dev/null 2>&1; then
	curl -L "$url_tarball" | \
		tar xzv && \
	mv -f "$HOME/dotfiles-master" "$path_dotfiles"
else
	printf 'ERROR: command git wget or curl not found.\n' 1>&2
	exit 1
fi && \
sh "$path_dotfiles/etc/link.sh"
