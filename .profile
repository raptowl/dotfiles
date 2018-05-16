# load $HOME/.profile.dotold
if [ -f "$HOME/.profile.dotold" ]; then
    . "$HOME/.profile.dotold"
fi

# add $HOME/bin to $PATH
export PATH="$HOME/bin:$PATH"

# set $EDITOR
export EDITOR="vim"

# load $HOME/.profile_local
if [ -f "$HOME/.profile_local" ]; then
    . "$HOME/.profile_local"
fi

