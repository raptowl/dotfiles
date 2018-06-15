# load settings
if [ -f "$HOME/.bash_profile.dotold" ]; then
    . "$HOME/.bash_profile_dotold"
elif [ -f "$HOME/.bash_login" ]; then
    . "$HOME/.bash_login"
elif [ -f "$HOME/.profile" ]; then
    . "$HOME/.profile"
fi

# add $HOME/bin to $PATH
export PATH="$HOME/bin:$PATH"

# set $EDITOR
export EDITOR="vim"

# load settings
if [ -f "$HOME/.bash_profile_local" ]; then
    . "$HOME/.bash_profile_local"
fi

