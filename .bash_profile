# load the setting of $PATH from $HOME/.path
if [ -f "$HOME/.path.sh" ]
then
    . "$HOME/.path.sh"
else
    printf "WARNING: %s/.path.sh not found.\\n" "$HOME" 1>&2
fi

# load .bashrc
if [ -f "$HOME/.bashrc" ]
then
    . "$HOME/.bashrc"
else
    printf "WARNING: %s/.bashrc not found.\\n" "$HOME" 1>&2
fi

