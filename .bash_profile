# load default settings
for l_path in "$HOME/.bash_profile.dotold" \
              "$HOME/.bash_login" \
              "$HOME/.profile"; do
  if [ -r "$l_path" ]; then
    . "$l_path"
    break
  fi
done
unset l_path

# set default access permissions
umask 0022

# set a environment variable "$DOTFILES_LOC"
export DOTFILES_LOC="$HOME/.dotfiles"

# set the other environment variables
export LANG='ja_JP.UTF-8'
export INPUTRC="$HOME/.inputrc"
if type vim > /dev/null 2>&1; then
  export EDITOR="vim"
fi
export PATH="$DOTFILES_LOC/bin:$PATH"
for l_path in "$HOME/usr/bin" \
              "$HOME/usr/shellshoccar/bin" \
              "$HOME/usr/kotoriotoko/BIN"; do
  if [ -d "$l_path" ]; then
    export PATH="${l_path}:$PATH"
  fi
done
unset l_path

# load local settings
if [ -r "$HOME/usr/local/bash_profile" ]; then
  . "$HOME/usr/local/bash_profile"
fi
