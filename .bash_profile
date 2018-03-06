if [ -f $HOME/.bashrc ]
then
    source $HOME/.bashrc
fi

############################################################
# DOTFILES
############################################################
# define $DOTPATH, which indicate the path to .dotfiles.
export DOTPATH="$HOME/.dotfiles"

############################################################
# PATH
############################################################
# load the setting of $PATH from $HOME/.path.
path_dotpath="$HOME/.path"
if [ ! -f $path_dotpath ]
then
    printf "Error: $path_dotpath not found.\n" 1>&2
else
    for tmppath in $(cat $path_dotpath | \
                     sed -e '/^ *#/d' \
                         -e "s%\$HOME%$HOME%")
    do
        PATH="${PATH}:${tmppath}"
    done
    export PATH
    unset tmppath
fi
unset path_dotpath

