#!/bin/sh

set -u
umask 0022

# url of git-completion script
url_script='raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash'

# make a directory to install script
if [ ! -d "$HOME/usr/local" ]; then
	mkdir -p "$HOME/usr/local"
fi

# main routine
if command -v curl >/dev/null 2>&1; then
	curl -L "$url_script" >"$HOME/usr/local/git-completion.bash"
elif command -v wget >/dev/null 2>&1; then
	wget -O - "$url_script" >"$HOME/usr/local/git-completion.bash"
else
	printf 'ERROR: command curl or wget not found.\n' >&2
	exit 1
fi
