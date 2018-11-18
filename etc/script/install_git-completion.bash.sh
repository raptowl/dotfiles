#!/bin/sh

set -e -u
umask 0022

url_script='raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash'

if [ ! -d "$HOME/usr" ]; then
	mkdir -p "$HOME/usr"
fi

if type curl >/dev/null 2>&1; then
	curl -L "$url_script" >"$HOME/usr/.git-completion.bash"
elif type wget >/dev/null 2>&1; then
	wget -O - "$url_script" >"$HOME/usr/.git-completion.bash"
else
	printf 'ERROR: command curl or wget not found.\n' >&2
	exit 1
fi
