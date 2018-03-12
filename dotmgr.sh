#!/bin/sh

set -u

# the path indicates the dotfiles directory
path_dotfiles="$HOME/.dotfiles"

if [ $# -eq 0 ]
then
    # show usage
    cat << EOF
usage: dotmgr.sh <command> [<arg>]

<commands>
deploy      put symbolic links of dotfiles to \$HOME
undeploy    remove symbolic links of dotfiles from \$HOME
install     build specific software
uninstall   remove built software
EOF
elif [ "$1" = "deploy" ]
then
    # put symbolic links of dotfiles to $HOME
    for i in $(find "$path_dotfiles" -maxdepth 1 | \
               sed -e "s%$path_dotfiles/%%" | \
               grep -v \
                    -e "^$path_dotfiles\$" \
                    -e "^\\.\$" \
                    -e "^\\.\\.\$" \
                    -e "^\\.git\$" \
                    -e "^\\.gitignore\$" \
                    -e "^LICENSE\$" \
                    -e "^README\\.md\$" \
                    -e "^dotmgr\\.sh\$" \
                    -e "^etc\$")
    do
        # if dotfiles has already been linked, skip the process
        if file "$HOME/$i" | \
           grep -e "symbolic" | \
           grep -e "$path_dotfiles" > /dev/null 2>&1
        then
            printf "WARNING: %s/%s has already been linked.\\n" "$HOME" "$i" 1>&2
            continue
        fi

        # if there are original files in $HOME, rename it
        if [ -f "$HOME/$i" ] || [ -d "$HOME/$i" ]
        then
            mv -v "$HOME/$i" "$HOME/${i}.dotold"
        fi

        # put symbolic link of dotfiles to $HOME
        ln -fsv "$path_dotfiles/$i" "$HOME/$i"
    done
elif [ "$1" = "undeploy" ]
then
    # remove symbolic links of dotfiles from $HOME
    find "$HOME" -maxdepth 1 -exec file {} + | \
    grep -e "symbolic" | \
    grep -e "$path_dotfiles" | \
    sed -e "s/: .*\$//" | \
    xargs rm -fv

    # if there are dotold files, rename them to their original name
    for i in $(find "$HOME" -maxdepth 1 | \
               grep -e "\\.dotold\$" | \
               sed -e "s/\\.dotold\$//")
    do
        mv -v "${i}.dotold" "$i"
    done
elif [ "$1" = "install" ]
then
    # build specific software
    if [ $# -eq 1 ]
    then
        cat << EOF
The following software is available.
$(find "$path_dotfiles/etc/dotmgr.d" | \
  grep -e "install" | \
  sed -e "s/^.*install-//" \
      -e "s/\\.sh\$//" \
      -e "s/^/\\t/")
EOF
    exit 0
    fi

elif [ "$1" = "uninstall" ]
then
    # remove built software
    :
else
    printf "ERROR: command %s is not defined.\\n" "$1" 1>&2
    exit 1
fi

