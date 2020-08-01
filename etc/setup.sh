#!/bin/sh

# initializing
set -u
umask 0022

# set variables
url_gitrepo='https://github.com/raptowl/dotfiles.git'
url_tarball='github.com/raptowl/dotfiles/archive/master.tar.gz'

# set a environment variable "$DOTFILES_DIR"
current_dir=$(pwd | tr -d '\n')
DOTFILES_DIR="$current_dir/.dotfiles"
export DOTFILES_DIR

# make a dotfiles_dir file
if mkdir -p "$HOME/usr/local"; then
  echo "$DOTFILES_DIR" > "$HOME/usr/local/dotfiles_dir"
else
  printf 'ERROR: could not make a directory at %s .\n' "$HOME/usr/local" >&2
  exit 1
fi

# main routine
if type git > /dev/null 2>&1; then
  git clone "$url_gitrepo" "$DOTFILES_DIR"
elif type curl > /dev/null 2>&1; then
  curl -L "$url_tarball" \
    | tar xzv \
    && mv -f "$current_dir/dotfiles-master" "$DOTFILES_DIR"
elif type wget > /dev/null 2>&1; then
  wget -O - "$url_tarball" \
    | tar xzv \
    && mv -f "$current_dir/dotfiles-master" "$DOTFILES_DIR"
else
  printf 'ERROR: command git wget or curl not found.\n' >&2
  exit 1
fi

# deploy configuration files
"$DOTFILES_DIR/bin/dotutil" link | sh
