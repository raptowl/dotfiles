#!/bin/sh

set -u
umask 0022

# path to the temporary directory
path_tmproot="$HOME/tmp$$"

# url of the git repository of 'bash-completion'
url_gitrepo='https://github.com/scop/bash-completion.git'

# url of the tarball of 'bash-completion'
url_tarball='github.com/scop/bash-completion/archive/master.tar.gz'

# remove tmporary directory
remove_tmproot() {
	if [ -d "$path_tmproot" ]; then
		rm -rf "$path_tmproot"
	fi
}
trap 'remove_tmproot' 1 2 3 15

# output error and exit if command 'autoreconf' is not installed
if ! type autoreconf >/dev/null 2>&1; then
	printf 'ERROR: command autoreconf not found.\n' >&2
	exit 1
fi

# output error and exit if command 'make' is not installed
if ! type make >/dev/null 2>&1; then
	printf 'ERROR: command make not found.\n' >&2
	exit 1
fi

# make a directory which contains local applications
if [ ! -d "$HOME/usr" ]; then
	mkdir -p "$HOME/usr"
fi

# main routine
mkdir -p "$path_tmproot"
cd "$path_tmproot" || exit 1
if type git >/dev/null 2>&1; then
	git clone "$url_gitrepo" "$path_tmproot/bash-completion-master"
elif type curl >/dev/null 2>&1; then
	curl -L "$url_tarball" |
		tar xvz
elif type wget >/dev/null 2>&1; then
	wget -O - "$url_tarball" |
		tar xvz
else
	printf 'ERROR: command git, curl or wget not found.\n' >&2
	exit 1
fi &&
cd "$path_tmproot/bash-completion-master" || exit 1
autoreconf -i
./configure --prefix="$HOME/usr/bash-completion"
make
make install

# remove tmporary directory
remove_tmproot
