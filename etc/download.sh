#!/bin/sh

# if any undefined variables are referred,
# show error to standard output.
set -u

# define variables.
dotpath="$HOME/.dotfiles"
url_gitrepo="https://github.com/raptowl/dotfiles.git"
url_tararch="https://github.com/raptowl/dotfiles/archive/master.tar.gz"
name_tararch="dotfiles-master"

# define functions.
is_exist() {
    type $1 > /dev/null 2>&1
    return $?
}

############################################################
# main routine
############################################################

if is_exist "git"
then
    git clone "$url_gitrepo" "$dotpath"
elif is_exist "wget"
then
    wget -O - "$url_tararch" | tar xzv
    if [ ! -d "$name_tararch" ]
    then
        printf "Error: $name_tararch not found.\n" 1>&2
        exit 1
    fi
    mv -v "$name_tararch" "$dotpath"
elif is_exist "curl"
then
    curl -L "$url_tararch" | tar xzv
    if [ ! -d "$name_tararch" ]
    then
        printf "Error: $name_tararch not found.\n" 1>&2
        exit 1
    fi
    mv -v "$name_tararch" "$dotpath"
else
    printf "Error: command 'git', 'wget' or 'curl' not found.\n" 1>&2
    exit 1
fi
exit 0

