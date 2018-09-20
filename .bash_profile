if [ -f "$HOME/.bash_profile.dotold" ]; then
	. "$HOME/.bash_profile.dotold"
elif [ -f "$HOME/.bash_login" ]; then
	. "$HOME/.bash_login"
elif [ -f "$HOME/.profile" ]; then
	. "$HOME/.profile"
fi

export PATH="$HOME/bin:$PATH"
export EDITOR="vim"
export INPUTRC="$HOME/.inputrc"

if [ -f "$HOME/.bash_profile_local" ]; then
	. "$HOME/.bash_profile_local"
fi
