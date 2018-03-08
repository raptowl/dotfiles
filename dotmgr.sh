#!/bin/sh

############################################################
# VARIABLES, FUNCTIONS
############################################################

set -u
. $DOTFILES/etc/lib.sh

# dotfiles which is excluded
exclude='. .. .git .gitignore LICENSE README.md dotmgr.sh
etc'

# show usage to standard output
show_usage() {
cat << EOF
usage: dotmgr.sh <command> [<arg>]

<commands>
deploy      put symbolic links of dotfiles to \$HOME
undeploy    remove symbolic links of dotfiles from \$HOME
install     build specific software
uninstall   remove built software
EOF
}

############################################################
# MAIN ROUTINE
############################################################

# if there is no arguments,
# show usage of this command
if [ $# -eq 0 ]
then
    show_usage
    exit 0
# if there are any arguments, operate dotfiles directory
elif [ $# -ge 1 ]
then
    case $1 in
    # put symbolic links of dotfiles to $HOME
    'deploy' )
        for i in $(ls -a $DOTFILES)
        do
            for j in $exclude
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
            ln -fsv $DOTFILES/$i $HOME/$i
        done
        ;;
    # remove symbolic links of dotfiles from $HOME
    'undeploy' )
        for i in $(ls -a $DOTFILES)
        do
            for j in $exclude
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
    # build specific software
    'install' )
        :
        ;;
    # remove built software
    'uninstall' )
        :
        ;;
    # if the command is incorrect, return error
    * )
        printf "Error: command $1 is not defined.\n" 1>&2
        exit 1
        ;;
    esac
    exit 0
fi

