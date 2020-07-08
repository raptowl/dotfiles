# set a environment variable "$DOTFILES_DIR"
export DOTFILES_DIR=$(grep '^..*$' "$HOME/usr/local/dotfiles_dir" \
                        | head -n 1 \
                        | tr -d '\n')

# load configure function
. "$DOTFILES_DIR/etc/bash_profile_base"

# load configuration
_load_bash_configuration "$HOME/.profile.dotold"

# unset configure function
unset -f _load_bash_configuration
