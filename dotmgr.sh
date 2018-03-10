#!/bin/sh

############################################################
# PREPROCESSING
############################################################

set -u
. $DOTFILES/etc/lib.sh

############################################################
# VARIABLES, FUNCTIONS
############################################################

# dotfiles which is excluded
exclude='. .. .git .gitignore LICENSE README.md dotmgr.sh
etc'

# extension to replace origin configuration files
ext='dotold'

# error code of the whole of this command
return_stat=0

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
                if [ -f $HOME/${i}.${ext} -o -d $HOME/${i}.${ext} ]
                then
                    Msg_warn "$HOME/${i}.${ext} has already existed.\n"
                else
                    {
                    mv $HOME/$i $HOME/${i}.${ext}
                    Msg_done "renamed $HOME/$i to $HOME/${i}.${ext}\n"
                    ln -fs $DOTFILES/$i $HOME/$i
                    Msg_done "linked $DOTFILES/$i to $HOME/${i}\n"
                    } || \
                    {
                        Msg_err "deploying $DOTFILES/$i to $HOME/$i not successed.\n"
                        return_stat=1
                    }
                fi
            else
                {
                ln -fs $DOTFILES/$i $HOME/$i
                Msg_done "linked $DOTFILES/$i to $HOME/${i}\n"
                } || \
                {
                Msg_err "deploying $DOTFILES/$i to $HOME/$i not successed.\n"
                return_stat=1
                }
            fi
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
                {
                rm $HOME/$i
                Msg_done "removed $HOME/${i}.\n"
                } || \
                {
                Msg_err "removing $HOME/${i} not successed.\n"
                return_stat=1
                }
            fi
            if [ -f $HOME/${i}.${ext} -o -d $HOME/${i}.${ext} ]
            then
                {
                mv $HOME/${i}.${ext} $HOME/${i}
                Msg_done "renamed $HOME/${i}.${ext} to $HOME/${i}.\n"
                } || \
                {
                Msg_err "renaming $HOME/${i}.${ext} to $HOME/$i not successed.\n"
                return_stat=1
                }
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
        Msg_err "command $1 is not defined.\n"
        return_stat=1
        ;;
    esac
    exit $return_stat
fi

