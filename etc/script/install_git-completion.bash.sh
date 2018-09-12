#!/bin/sh

set -eu
umask 0022

url_script='raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash'

if type curl > /dev/null 2>&1; then
	curl -L "$url_script" > "$HOME/.git-completion.bash"
elif type wget > /dev/null 2>&1; then
	wget -O - "$url_script" > "$HOME/.git-completion.bash"
else
	printf 'ERROR: command curl or wget not found.\n' 1>&2
	exit 1
fi

