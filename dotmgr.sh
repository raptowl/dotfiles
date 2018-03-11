#!/bin/sh

set -u

# the path indicates the dotfiles directory
path_dotfiles="$HOME/.dotfiles"

if [ $# -eq 0 ]
then
    # show usage
    cat 1>&2 << EOF
usage: dotmgr.sh <command> [<arg>]

<commands>
deploy      put symbolic links of dotfiles to \$HOME
undeploy    remove symbolic links of dotfiles from \$HOME
install     build specific software
uninstall   remove built software
EOF
    exit 1
elif [ "$1" = "deploy" ]
then
    # put symbolic links of dotfiles to $HOME
    for i in $(ls -a "$path_dotfiles" | \
               grep -v \
                    -e "^\.\$" \
                    -e "^\.\.\$" \
                    -e "^\.git\$" \
                    -e "^\.gitignore\$" \
                    -e "^LICENSE\$" \
                    -e "^README\.md\$" \
                    -e "^dotmgr\.sh\$" \
                    -e "^etc\$")
    do
        # if dotfiles has already been linked, skip the process
        if file "$HOME/$i" | \
           grep -e "symbolic" | \
           grep -e "$path_dotfiles" > /dev/null 2>&1
        then
            printf "WARNING: $HOME/$i has already been linked.\n" 1>&2
            continue
        fi

        # if there are original files in $HOME, rename it
        if [ -f "$HOME/$i" -o -d "$HOME/$i" ]
        then
            mv -v "$HOME/$i" "$HOME/${i}.dotold"
        fi

        # put symbolic link of dotfiles to $HOME
        ln -fsv "$path_dotfiles/$i" "$HOME/$i"
    done
elif [ "$1" = "undeploy" ]
then
    # remove symbolic links of dotfiles from $HOME
    for i in $(ls -a "$HOME" | \
               sed -e "s%^%$HOME/%" | \
               xargs file | \
               grep -e "symbolic" | \
               grep -e "$path_dotfiles" | \
               sed -e "s/: .*\$//")
    do
        rm -v $i
    done

    # if there are dotold files, rename them to their original name
    for i in $(ls -a "$HOME" | \
               grep -e "\.dotold\$" | \
               sed -e "s/\.dotold\$//")
    do
        mv -v "$HOME/${i}.dotold" "$HOME/$i"
    done
elif [ "$1" = "install" ]
then
    # build specific software
    :
elif [ "$1" = "uninstall" ]
then
    # remove built software
    :
else
    printf "ERROR: command $1 is not defined.\n" 1>&2
    exit 1
fi

