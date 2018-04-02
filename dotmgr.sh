#!/bin/sh

set -u

# the path indicates the dotfiles directory
path_dotfiles="$HOME/.dotfiles"

# main process
if [ $# -eq 0 ]; then
    # print message and exit with error

    cat 1>&2 << _EOT_
dotmgr.sh is a dotfiles manager script.
Please run "dotmgr.sh --help" to show the usage of this command.
_EOT_
    exit 1
elif [ "$1" = "--help" ]; then
    # show usage

    cat << _EOT_
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
    download and set-up specific software

uninstall [arg]...
    remove self-set-up software
_EOT_
elif [ "$1" = "deploy" ]; then
    # put symbolic links of dotfiles to $HOME

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
    printf "%s\\n" "$deployfiles" |
    xargs -I {} sh -c \
        "if [ -f \"$HOME/{}\" ] || [ -d \"$HOME/{}\" ]; then
            mv -fv \"$HOME/{}\" \"$HOME/{}.dotold\"
        fi"

    # put symbolic links
    printf "%s\\n" "$deployfiles" |
    xargs -I {} ln -fsv "$path_dotfiles/{}" "$HOME/{}"
elif [ "$1" = "undeploy" ]; then
    # remove symbolic links of dotfiles from $HOME

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
elif [ "$1" = "install" ]; then
    # download and set-up specific software

    shift 1
    if [ $# -eq 0 ]; then
        # if there are no arguments, show software whose install script is available
        cat << _EOT_
The install script of follwing software is available.

$(find "$path_dotfiles/etc/dotmgr.d" |
  grep -e "/install" |
  sed -e "s/^.*install_//" \
      -e "s/\\.sh\$//" |
  sort |
  sed -e "s/^/\\t/")
_EOT_
    else
        # call each install script
        printf "%s\\n" "$@" |
        sort |
        uniq |
        xargs -I {} sh -c \
            "if [ -f \"$path_dotfiles/etc/dotmgr.d/install_{}.sh\" ]; then
                sh \"$path_dotfiles/etc/dotmgr.d/install_{}.sh\"
            else
                printf \"ERROR: %s is not available.\\n\" \"{}\" 1>&2
            fi"
    fi
elif [ "$1" = "uninstall" ]; then
    # remove self-set-up software

    shift 1
    if [ $# -eq 0 ]; then
        # if there are no arguments, show software whose uninstall script is avaiable
        cat << _EOT_
The uninstall script of following software is available.

$(find "$path_dotfiles/etc/dotmgr.d" |
  grep -e "/uninstall" |
  sed -e "s/^.*uninstall_//" \
      -e "s/\\.sh\$//" |
  sort |
  sed -e "s/^/\\t/")
_EOT_
    else
        # call each uninstall script
        printf "%s\\n" "$@" |
        sort |
        uniq |
        xargs -I {} sh -c \
            "if [ -f \"$path_dotfiles/etc/dotmgr.d/uninstall_{}.sh\" ]; then
                sh \"$path_dotfiles/etc/dotmgr.d/uninstall_{}.sh\"
            else
                printf \"ERROR: %s is not available.\\n\" \"{}\" 1>&2
            fi"
    fi
else
    # print error message and exit with error

    printf "ERROR: command %s is not defined.\\n" "$1" 1>&2
    exit 1
fi

