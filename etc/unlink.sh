#!/bin/sh

set -u

# the path indicates the dotfiles directory
path_dotfiles="$HOME/.dotfiles"

# remove symbolic links of dotfiles
find "$HOME" -maxdepth 1 -print0    |
xargs -0 file                       |
grep -e "symbolic"                  |
grep -e "$path_dotfiles"            |
sed -e "s/: .*\$//"                 |
xargs rm -rfv

# if there are dotold files, rename them to their original name
find "$HOME" -maxdepth 1    |
grep -e "\\.dotold\$"       |
sed -e "s/\\.dotold\$//"    |
xargs -I {} mv -fv "{}.dotold" "{}"

# remove symbolic links of config dotfiles
find "$HOME/.config" -maxdepth 1 -print0    |
xargs -0 file                               |
grep -e "symbolic"                          |
grep -e "$path_dotfiles/.config"            |
sed -e "s/: .*\$//"                         |
xargs rm -rfv

# if there are dotold files, rename them to their original name
find "$HOME/.config" -maxdepth 1    |
grep -e "\\.dotold\$"               |
sed -e "s/\\.dotold\$//"            |
xargs -I {} mv -fv "{}.dotold" "{}"

# if $HOME/.config is empty, remove the directory $HOME/.config 
find "$HOME" -maxdepth 1 -type d -empty |
grep -e "^$HOME/.config\$"              |
xargs rm -rf

