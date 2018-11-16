# load the default login settings
if [ -f "$HOME/.bash_profile.dotold" ]; then
	. "$HOME/.bash_profile.dotold"
elif [ -f "$HOME/.bash_login" ]; then
	. "$HOME/.bash_login"
elif [ -f "$HOME/.profile" ]; then
	. "$HOME/.profile"
fi

# set the environment variables
export PATH="$HOME/bin:$PATH"
export EDITOR="vim"
export INPUTRC="$HOME/.inputrc"

# load the interactive settings
if [ -f "$HOME/.bashrc" ] && [ -n "$SSH_TTY" ]; then
	. "$HOME/.bashrc"
fi

# load the local login settings
if [ -f "$HOME/.bash_profile_local" ]; then
	. "$HOME/.bash_profile_local"
fi
