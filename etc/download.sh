#!/bin/sh

############################################################
# VARIABLES, FUNCTIONS
############################################################

set -u

# this indicates the path to .dotfiles
export DOTFILES="$HOME/.dotfiles"
# the url indicates the git repository on github
url_gitrepo="https://github.com/raptowl/dotfiles.git"
# the url indicates the tar archive of this repository
url_tararch="https://github.com/raptowl/dotfiles/archive/master.tar.gz"
# the name of tar archive on master branch
name_tararch="dotfiles-master"
# the name of script which manages this repository
name_mgrsh="dotmgr.sh"
# the error code which this script returns
return_stat=0

# define functions
is_exist() {
    type $1 > /dev/null 2>&1
    return $?
}

# move tarball archive to $DOTFILES
move_tar() {
    if [ ! -d "$name_tararch" ]
    then
        printf "Error: $name_tararch not found.\n" 1>&2
        exit 1
    fi
    mv -v "$name_tararch" "$DOTFILES"
    return $?
}

# deploy dotfiles in $DOTFILES
# using by the script $name_mgrsh
auto_deploy() {
    if [ ! -f "$DOTFILES/$name_mgrsh" ]
    then
        printf "Error: $DOTFILES/$name_mgrsh not found.\n" 1>&2
        return 1
    fi
    $DOTFILES/$name_mgrsh deploy
    return $?
}

############################################################
# MAIN ROUTINE
############################################################

if is_exist "git"
then
    {
    git clone "$url_gitrepo" "$DOTFILES" && \
    auto_deploy
    } || return_stat=1
elif is_exist "wget"
then
    {
    wget -O - "$url_tararch" | tar xzv && \
    move_tar && \
    auto_deploy
    } || return_stat=1
elif is_exist "curl"
then
    {
    curl -L "$url_tararch" | tar xzv && \
    move_tar && \
    auto_deploy
    } || return_stat=1
else
    printf "Error: command 'git', 'wget' or 'curl' not found.\n" 1>&2
    return_stat=1
fi
exit $return_stat

