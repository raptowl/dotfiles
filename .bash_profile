# load one of ~/.bash_profile.dotold, ~/.bash_login and ~/.profile or not
if [ -f "$HOME/.bash_profile.dotold" ]; then
    printf "QUERY: load ~/.bash_profile.dotold ? [y/(other)]: "
    read -r ans
    if [ "$ans" = "y" ]; then
        . "$HOME/.bash_profile.dotold"
    fi
    unset ans
elif [ -f "$HOME/.bash_login" ]; then
    printf "QUERY: load ~/.bash_login ? [y/(other)]: "
    read -r ans
    if [ "$ans" = "y" ]; then
        . "$HOME/.bash_login"
    fi
    unset ans
elif [ -f "$HOME/.profile" ]; then
    printf "QUERY: load ~/.profile ? [y/(other)]: "
    read -r ans
    if [ "$ans" = "y" ]; then
        . "$HOME/.profile"
    fi
    unset ans
fi

# add $HOME/bin to PATH
export PATH="$HOME/bin:${PATH}"

# define a variable EDITOR
export EDITOR=vim

# load the setting from $HOME/.extra.sh when logined
if [ -f "$HOME/.extra.sh" ]; then
    . "$HOME/.extra.sh"
else
    printf "WARNING: %s/.extra.sh not found.\\n" "$HOME" 1>&2
fi

# load $HOME/.bashrc
if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
else
    printf "WARNING: %s/.bashrc not found.\\n" "$HOME" 1>&2
fi

