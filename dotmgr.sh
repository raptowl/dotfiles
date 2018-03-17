#!/bin/sh

set -u

# the path indicates the dotfiles directory
path_dotfiles="$HOME/.dotfiles"

# main process
if [ $# -eq 0 ] # print message and exit with error
then
    cat 1>&2 << EOF
dotmgr.sh is a dotfiles manager script.
Please run "dotmgr.sh --help" to show the usage of this command.
EOF
    exit 1
elif [ "$1" = "--help" ] # show usage
then
    cat << EOF
usage: dotmgr.sh [--help] <command> [arg]...

[option]
--help
    show usage of this command

<commands>
deploy
    put symbolic links of dotfiles to \$HOME

undeploy
    remove symbolic links of dotfiles from \$HOME

install [arg]...
    build specific software

uninstall [arg]...
    remove built software
EOF
elif [ "$1" = "deploy" ] # put symbolic links of dotfiles to $HOME
then
    # get the name list of files to put symbolic links to $HOME
    deployfiles="$(find "$path_dotfiles" -maxdepth 1 |
    grep -v -e "$path_dotfiles\$" \
            -e "README\\.md\$" \
            -e "\\.gitignore\$" \
            -e "etc\$" \
            -e "dotmgr\\.sh\$" \
            -e "\\.git\$" \
            -e "LICENSE\$" |
    sed -e "s%$path_dotfiles%$HOME%" |
    xargs file |
    grep -v -e "symbolic" |
    grep -v -e "$path_dotfiles" |
    sed -e "s%$HOME/%%" \
        -e "s/: .*//")"

    # rename the user original dotfiles to dotold name
    echo "$deployfiles" |
    xargs -I {} sh -c \
        "if [ -f \"$HOME/{}\" ] || [ -d \"$HOME/{}\" ]
        then
            mv -fv \"$HOME/{}\" \"$HOME/{}.dotold\"
        fi"

    # put symbolic links
    echo "$deployfiles" |
    xargs -I {} ln -fsv "$path_dotfiles/{}" "$HOME/{}"
elif [ "$1" = "undeploy" ] # remove symbolic links of dotfiles from $HOME
then
    # remove symbolic links
    find "$HOME" -maxdepth 1 -print0 |
    xargs -0 file |
    grep -e "symbolic" |
    grep -e "$path_dotfiles" |
    sed -e "s/: .*\$//" |
    xargs rm -fv

    # if there are dotold files, rename them to their original name
    find "$HOME" -maxdepth 1 |
    grep -e "\\.dotold\$" |
    sed -e "s/\\.dotold\$//" |
    xargs -I {} mv -fv "{}.dotold" "{}"
elif [ "$1" = "install" ] # build specific software
then
    shift 1
    if [ $# -eq 0 ]
    then
        cat << EOF
The following software is available.
$(find "$path_dotfiles/etc/dotmgr.d" |
  grep -e "install" |
  sed -e "s/^.*install-//" \
      -e "s/\\.sh\$//" \
      -e "s/^/\\t/")
EOF
    else
        installsw="$*"
        echo "$installsw"
    fi
elif [ "$1" = "uninstall" ] # remove built software
then
    :
else # print error message and exit with error
    printf "ERROR: command %s is not defined.\\n" "$1" 1>&2
    exit 1
fi

