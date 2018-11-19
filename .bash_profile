# load the default login settings
if [ -f "$HOME/.bash_profile.dotold" ]; then
	. "$HOME/.bash_profile.dotold"
elif [ -f "$HOME/.bash_login" ]; then
	. "$HOME/.bash_login"
elif [ -f "$HOME/.profile" ]; then
	. "$HOME/.profile"
fi

# load the interactive settings
if [ -f "$HOME/.bashrc" ] && printf '%s\n' "$-" | grep -q -e 'i'; then
	. "$HOME/.bashrc"
fi

# load the local login settings
if [ -f "$HOME/usr/bash_profile_local" ]; then
	. "$HOME/usr/bash_profile_local"
fi
