#!/bin/sh

# define variables.
dotpath="$HOME/.dotfiles"
dotexclude='. .. .git LICENSE README.md dotmgr.sh etc'
dotgiturl='https://github.com/raptowl/dotfiles.git'
dottarurl='github.com/raptowl/dotfiles/archive/master.tar.gz'

if [ $# -eq 0 ] # get dotfiles from github repository.
then
    :
    exit 0
elif [ $# -ge 1 ] # operate dotfiles directory.
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
            if [ -f $HOME/$i -o -d $HOME/$i ]
            then
                mv -v $HOME/$i $HOME/${i}.old
            fi
            ln -fsv $dotpath/$i $HOME/$i
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
            rm -v $HOME/$i
            if [ -f $HOME/${i}.old -o -d $HOME/${i}.old ]
            then
                mv -v $HOME/${i}.old $HOME/${i}
            fi
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
fi

