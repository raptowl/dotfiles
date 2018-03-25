# add $HOME/bin to PATH
export PATH="$HOME/bin:${PATH}"

# define a variable EDITOR
export EDITOR=vim

# load $HOME/.bashrc
if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
else
    printf "WARNING: %s/.bashrc not found.\\n" "$HOME" 1>&2
fi

# load the setting from $HOME/.extra.sh when logined
if [ -f "$HOME/.extra.sh" ]; then
    . "$HOME/.extra.sh"
else
    printf "WARNING: %s/.extra.sh not found.\\n" "$HOME" 1>&2
fi

