#!/bin/sh

# define variables.
dotpath="$HOME/.dotfiles"
dotexclude='. .. .git LICENSE README.md dotmgr.sh etc'

if [ $# -eq 0 ] # if there is no arguments, behave as a libraries for self-made commands.
then
    :
elif [ $# -ge 1 ] # if there are any arguments, operate dotfiles directory.
then
    case $1 in
    'deploy' ) # put symbolic links of dotfiles to $HOME.
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
    'undeploy' ) # remove symbolic links of dotfiles from $HOME.
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
    'install' ) # build specific software.
        :
        ;;
    'uninstall' ) # remove built software.
        :
        ;;
    * ) # if the instruction is incorrect, return error.
        printf "Error: instruction $1 is not defined.\n" 1>&2
        exit 1
        ;;
    esac
    exit 0
fi

