#!/bin/sh

# define variables.
dotpath="$HOME/.dotfiles"
dotexclude='. .. .git LICENSE README.md bin dotmgr.sh etc lib'

############################################################

if [ $# -eq 1 ]
then
    if [ $1 = 'deploy' ] # deploy dotfiles.
    then
        for i in `ls -a $dotpath`
        do
            for j in $dotexclude
            do
                if [ $i = $j ]
                then
                    continue 2
                fi
            done
            ln -sf $dotpath/$i $HOME/$i
        done
        exit 0
    elif [ $1 = 'undeploy' ] # undeploy dotfiles.
    then
        for i in `ls -a $dotpath`
        do
            for j in $dotexclude
            do
                if [ $i = $j ]
                then
                    continue 2
                fi
            done
            rm $HOME/$i
        done
        exit 0
    elif [ $1 = 'install' ] # build software locally.
    then
        :
        exit 0
    elif [ $1 = 'uninstall' ] # delete built software locally.
    then
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

