#!/bin/sh


# initializing
set -u
umask 0022


# set variables
url_gitrepo='https://github.com/raptowl/dotfiles.git'
url_tarball='github.com/raptowl/dotfiles/archive/master.tar.gz'



# make sure the existence of the home directory
if ! env \
       | grep -e '^HOME='; then
  printf 'ERROR: the environment variable HOME is not defined.\n' >&2
  exit 1
fi


if [ ! -d "$HOME" ]; then
  printf 'ERROR: the home directory HOME cannot be accessed.\n' >&2
  exit 1
fi


# set a environment variable "$DOTFILES_DIR"
DOTFILES_DIR="$HOME/.dotfiles"
export DOTFILES_DIR


# main routine
cd "$HOME" \
  || exit 1
if type git > /dev/null 2>&1; then
  git clone "$url_gitrepo" "$DOTFILES_DIR"
elif type curl > /dev/null 2>&1; then
  curl -L "$url_tarball" \
    | tar xzv \
    && mv -f "$HOME/dotfiles-master" "$DOTFILES_DIR"
elif type wget > /dev/null 2>&1; then
  wget -O - "$url_tarball" \
    | tar xzv \
    && mv -f "$HOME/dotfiles-master" "$DOTFILES_DIR"
else
  printf 'ERROR: command git wget or curl not found.\n' >&2
  exit 1
fi


# deploy configuration files
sh "$DOTFILES_DIR/etc/deploy.sh"
