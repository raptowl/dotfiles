#!/bin/sh

set -u

# the path indicates the dotfiles directory
path_dotfiles="$HOME/.dotfiles"

# the url indicates the git repository on github
url_gitrepo="https://github.com/raptowl/dotfiles.git"

# the url indicates the tar archive of this repository
url_tarball="github.com/raptowl/dotfiles/archive/master.tar.gz"

cd "$HOME" || exit
if command -v git > /dev/null 2>&1; then
    # download the repository using by git
    git clone "$url_gitrepo" "$path_dotfiles" &&

    # deploy the dotfiles using by dotmgr.sh
    if [ ! -f "$path_dotfiles/dotmgr.sh" ]; then
        printf "ERROR: %s/dotmgr.sh not found.\\n" "$path_dotfiles" 1>&2
        exit 1
    fi
    sh "$path_dotfiles/dotmgr.sh" deploy
elif command -v wget > /dev/null 2>&1; then
    # download the repository using by wget
    wget -O - "$url_tarball" | tar xzv &&

    # rename the directory
    if [ ! -d "$HOME/dotfiles-master" ]; then
        printf "ERROR: %s/dotfiles-master not found.\\n" "$HOME" 1>&2
        exit 1
    fi
    mv -fv "$HOME/dotfiles-master" "$path_dotfiles" &&

    # deploy the dotfiles using by $path_dotfiles/dotmgr.sh
    if [ ! -f "$path_dotfiles/dotmgr.sh" ]; then
        printf "ERROR: %s/dotmgr.sh not found.\\n" "$path_dotfiles" 1>&2
        exit 1
    fi
    sh "$path_dotfiles/dotmgr.sh" deploy
elif command -v curl > /dev/null 2>&1; then
    # download the repository using by curl
    curl -L "$url_tarball" | tar xzv &&

    # rename the directory
    if [ ! -d "$HOME/dotfiles-master" ]; then
        printf "ERROR: %s/dotfiles-master not found.\\n" "$HOME" 1>&2
        exit 1
    fi
    mv -fv "$HOME/dotfiles-master" "$path_dotfiles" &&

    # deploy the dotfiles using by $path_dotfiles/dotmgr.sh
    if [ ! -f "$path_dotfiles/dotmgr.sh" ]; then
        printf "ERROR: %s/dotmgr.sh not found.\\n" "$path_dotfiles" 1>&2
        exit 1
    fi
    sh "$path_dotfiles/dotmgr.sh" deploy
else
    printf "ERROR: at least one command of \"git\" \"wget\" or \"curl\" is necessary.\\n" 1>&2
    exit 1
fi

