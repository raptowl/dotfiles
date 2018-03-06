#!/bin/sh

# if any undefined variables are referred to,
# show error to standard output.
set -u

# define variables.
dotpath="$HOME/.dotfiles"
dotexclude='. .. .git .gitignore LICENSE README.md dotmgr.sh etc lib'

############################################################
# main routine
############################################################

# if there is no arguments,
# show usage of this command.
if [ $# -eq 0 ]
then
    :
    exit 0
# if there are any arguments, operate dotfiles directory.
elif [ $# -ge 1 ]
then
    case $1 in
    # put symbolic links of dotfiles to $HOME.
    'deploy' )
        for i in $(ls -a $dotpath)
        do
            for j in $dotexclude
            do
                if [ $i = $j ]
                then
                    continue 2
                fi
            done
            if [ -f $HOME/$i -o -d $HOME/$i ]
            then
                mv -v $HOME/$i $HOME/${i}.old
            fi
            ln -fsv $dotpath/$i $HOME/$i
        done
        ;;
    # remove symbolic links of dotfiles from $HOME.
    'undeploy' )
        for i in $(ls -a $dotpath)
        do
            for j in $dotexclude
            do
                if [ $i = $j ]
                then
                    continue 2
                fi
            done
            if [ -h $HOME/$i ]
            then
                rm -v $HOME/$i
            fi
            if [ -f $HOME/${i}.old -o -d $HOME/${i}.old ]
            then
                mv -v $HOME/${i}.old $HOME/${i}
            fi
        done
        ;;
    # build specific software.
    'install' )
        :
        ;;
    # remove built software.
    'uninstall' )
        :
        ;;
    # if the instruction is incorrect, return error.
    * )
        printf "Error: instruction $1 is not defined.\n" 1>&2
        exit 1
        ;;
    esac
    exit 0
fi

