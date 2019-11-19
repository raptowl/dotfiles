# load default settings
[ -r "$HOME/.bash_profile.dotold" ] && . "$HOME/.bash_profile.dotold" ||
[ -r "$HOME/.bash_login" ] && . "$HOME/.bash_login" ||
[ -r "$HOME/.profile" ] && . "$HOME/.profile"

# set default access permissions
umask 0022

# load the environment variable 'DOTFILES_LOC'.
[ -r "$HOME/.dotloc" ] && . "$HOME/.dotloc" || printf 'WARNING: ~/.dotloc could not be read correctly.\n' >&2

# set the other environment variables
export LANG='ja_JP.UTF-8'
export INPUTRC="$HOME/.inputrc"
type vim > /dev/null 2>&1 && export EDITOR="vim"
export PATH="$HOME/bin:$PATH"
[ -d "$HOME/usr/bin" ] && export PATH="$HOME/usr/bin:$PATH"
[ -d "$HOME/usr/shellshoccar/bin" ] && export PATH="$HOME/usr/shellshoccar/bin:$PATH"
[ -d "$HOME/usr/kotoriotoko/BIN" ] && export PATH="$HOME/usr/kotoriotoko/BIN:$PATH"

# load local settings
[ -r "$HOME/usr/local/bash_profile" ] && . "$HOME/usr/local/bash_profile"
