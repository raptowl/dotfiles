# load the setting of $PATH from $HOME/.path
if [ -f "$HOME/.path.sh" ]
then
    . "$HOME/.path.sh"
else
    printf "WARNING: $HOME/.path.sh not found.\n" 1>&2
fi

# load .bashrc
if [ -f "$HOME/.bashrc" ]
then
    . "$HOME/.bashrc"
else
    printf "WARNING: $HOME/.bashrc not found.\n" 1>&2
fi

