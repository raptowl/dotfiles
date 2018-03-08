############################################################
# DOTFILES
############################################################
# define a environment variable $DOTFILES,
# which indicate the path to .dotfiles
export DOTFILES="$HOME/.dotfiles"

############################################################
# PATH
############################################################
# load the setting of $PATH from $HOME/.path
path_path="$HOME/.path"
if [ ! -f $path_path ]
then
    printf "Error: $path_path not found.\n" 1>&2
else
    for tmppath in $(cat $path_path | \
                     sed -e '/^ *#/d' \
                         -e "s%\$HOME%$HOME%")
    do
        PATH="${PATH}:${tmppath}"
    done
    export PATH
    unset tmppath
fi
unset path_path

############################################################
# LOAD BASHRC
############################################################
# if $HOME/.bashrc exists, load it
if [ -f $HOME/.bashrc ]
then
    . $HOME/.bashrc
fi

