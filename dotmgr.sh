#!/bin/sh

# define variables.
dotpath="$HOME/.dotfiles"
dotexclude='. .. .git LICENSE README.md dotmgr.sh etc'
dotgiturl='https://github.com/raptowl/dotfiles.git'
dottarurl='https://github.com/raptowl/dotfiles/archive/master.tar.gz'

if [ $# -eq 0 ] # get dotfiles from github repository.
then
    :
    exit 0
elif [ $# -ge 1 ] # operate dotfiles directory.
then
    case $1 in
    'deploy' ) # deploy dotfiles.
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
        ;;
    'undeploy' ) # undeploy dotfiles.
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
        ;;
    'install' ) # build software locally.
        :
        exit 0
        ;;
    'uninstall' ) # delete built software locally.
        :
        exit 0
        ;;
    * ) # if any other instructions, return error.
        echo "Error: instruction $1 is not defined." 1>&2
        exit 1
        ;;
    esac
fi

