#!/bin/sh

# define variables.
DOT_PATH="$HOME/.dotfiles"
DOT_EXCLUDE=". .. .git bin dotmgr.sh etc LICENSE README.md"

############################################################

if [ $# -eq 0 ]; then
    :
    exit 0
elif [ $# -eq 1 ]; then
    if [ $1 = "deploy" ]; then #deploy dotfiles.
        for i in `ls -a $DOT_PATH`; do
            for j in $DOT_EXCLUDE; do
                if [ $i = $j ]; then
                    continue 2
                fi
            done
            ln -sf $DOT_PATH/$i $HOME/$i
            echo $i
        done
        exit 0
    elif [ $1 = "undeploy" ]; then #undeploy dotfiles.
        :
        exit 0
    elif [ $1 = "install" ]; then # build software locally
        :
        exit 0
    elif [ $1 = "uninstall" ]; then # delete built software locally.
        :
        exit 0
    else # if any other instructions, return error.
        echo "Error: instruction $1 is not defined." 1>&2
        exit 1
    fi
else # if arguments are incorrect, return error.
    echo "Error: the number of arguments is incorrect." 1>&2
    exit 1
fi

