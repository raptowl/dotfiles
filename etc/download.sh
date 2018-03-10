#!/bin/sh

############################################################
# PREPROCESSING
############################################################

set -u
# $DOTFILES indicates the path to .dotfiles
export DOTFILES="$HOME/.dotfiles"

# load the lib.sh from remote
url_libsh="https://githubusetcontent.com/raptowl/dotfiles/master/etc/lib.sh"
path_tmpfile="$HOME/.tmp_lib.sh"
if type "wget" > /dev/null 2>&1
then
    wget -O - "$url_libsh" > $path_tmpfile
elif type "curl" > /dev/null 2>&1
    curl -L "$url_libsh" > $path_tmpfile
else
    printf "command wget or curl is necessary at least.\n" 2>&1
    exit 1
fi && \
. $path_tmpfile && \
rm $path_tmpfile
unset url_libsh path_tmpfile

############################################################
# VARIABLES, FUNCTIONS
############################################################

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

# move tarball archive to $DOTFILES
move_tar() {
    if [ ! -d "$name_tararch" ]
    then
        Msg_err "$name_tararch not found.\n"
        exit 1
    fi
    {
    mv -v "$name_tararch" "$DOTFILES"
    Msg_done "moved $name_tararch to ${DOTFILES}.\n"
    } || \
    {
    Msg_err "moving $name_tararch to $DOTFILES not successed.\n"
    exit 1
    }
    return $?
}

# deploy dotfiles in $DOTFILES
# using by the script $name_mgrsh
auto_deploy() {
    if [ ! -f "$DOTFILES/$name_mgrsh" ]
    then
        Msg_err "$DOTFILES/$name_mgrsh not found.\n"
        return 1
    fi
    $DOTFILES/$name_mgrsh deploy
    return $?
}

############################################################
# MAIN ROUTINE
############################################################

if Cmd_exist "git"
then
    {
    git clone "$url_gitrepo" "$DOTFILES" && \
    auto_deploy
    } || return_stat=1
elif Cmd_exist "wget"
then
    {
    wget -O - "$url_tararch" | tar xzv && \
    move_tar && \
    auto_deploy
    } || return_stat=1
elif Cmd_exist "curl"
then
    {
    curl -L "$url_tararch" | tar xzv && \
    move_tar && \
    auto_deploy
    } || return_stat=1
else
    Msg_err "command 'git', 'wget' or 'curl' not found.\n"
    return_stat=1
fi
exit $return_stat

