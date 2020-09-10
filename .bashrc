# load default settings
if [ -r "$HOME/.bashrc.dotold" ]; then
  . "$HOME/.bashrc.dotold"
fi


# set a environment variable "$DOTFILES_DIR"
if [ -r "$HOME/usr/local/dotfiles_dir" ]; then
  export DOTFILES_DIR=$(grep '^..*$' "$HOME/usr/local/dotfiles_dir" \
                          | head -n 1 \
                          | tr -d '\n')
else
  export DOTFILES_DIR="$HOME/.dotfiles"
fi


# set default access permissions
umask 0022


# set the other environment variables
export LANG='ja_JP.UTF-8'
export INPUTRC="$HOME/.inputrc"
if type vim > /dev/null 2>&1; then
  export EDITOR='vim'
fi
export PATH="$DOTFILES_DIR/bin:$PATH"
for l_path in "$HOME/usr/bin" \
              "$HOME/usr/shellshoccar/bin" \
              "$HOME/usr/kotoriotoko/BIN"; do
  if [ -d "$l_path" ]; then
    export PATH="${l_path}:$PATH"
  fi
done
unset l_path


# set aliases
alias ..='\cd ..'
alias ...='\cd ../..'
alias ....='\cd ../../..'
if ls --color >/dev/null 2>&1; then
  alias l='\ls --color=auto'
  alias ll='\ls -l --color=auto'
  alias la='\ls -a --color=auto'
  alias ls='\ls -la --color=auto'
else
  alias l='\ls -G'
  alias ll='\ls -l -G'
  alias la='\ls -a -G'
  alias ls='\ls -la -G'
fi


# load my lib modules and set functions for configuratin
. "$DOTFILES_DIR/lib/list_functions_recursively.sh"
. "$DOTFILES_DIR/lib/color_term_raw.sh"
wrap_control_sequence_for_prompt() {
  sed -e 's/\(\\033\)/\\[\1/g' \
      -e 's/\([0-9]m\)/\1\\]/g' \
    | sed -e 's/\\/\\\\/g'
}


# load extra modules
if [ -r "$HOME/usr/local/bash-completion/etc/profile.d/bash_completion.sh" ]; then
  . "$HOME/usr/local/bash-completion/etc/profile.d/bash_completion.sh"
fi


if [ -r "$HOME/usr/local/git-prompt.sh" ]; then
  . "$HOME/usr/local/git-prompt.sh"
  GIT_PS1_SHOWDIRTYSTATE=1
  GIT_PS1_SHOWSTASHSTATE=1
  GIT_PS1_SHOWUNTRACKEDFILES=1
  GIT_PS1_SHOWUPSTREAM='auto'
  GIT_PS1_STATESEPARATOR=':'
fi


if [ -r "$HOME/usr/local/init_conda" ]; then
  init_conda() {
    . "$HOME/usr/local/init_conda"
  }
fi


# set prompt
PS1=$(printf '%s' '$(__exit_status=$?; printf "__format_user__@__format_host__ " "\u" "\h"; if [ -n "$SSH_CLIENT" ]; then printf "__format_ssh__ " "[SSH]"; fi; if [ -r "$HOME/usr/local/git-prompt.sh" ]; then printf "__format_branch__" "$(__git_ps1 "(%s) ")"; fi; printf "__format_cd__ " "\w"; if [ $__exit_status -eq 0 ]; then printf "__format_good_status__ " "\$"; else printf "__format_bad_status__ " "\$"; fi)' \
        | sed -e 's/__format_user__/'"$(color_term_raw -b magenta none '%s' | wrap_control_sequence_for_prompt)"'/' \
              -e 's/__format_host__/'"$(color_term_raw -b magenta none '%s' | wrap_control_sequence_for_prompt)"'/' \
              -e 's/__format_ssh__/'"$(color_term_raw -b cyan none '%s' | wrap_control_sequence_for_prompt)"'/' \
              -e 's/__format_branch__/'"$(color_term_raw -b yellow none '%s' | wrap_control_sequence_for_prompt)"'/' \
              -e 's/__format_cd__/'"$(color_term_raw -b blue none '%s' | wrap_control_sequence_for_prompt)"'/' \
              -e 's/__format_good_status__/'"$(color_term_raw -b green none '%s' | wrap_control_sequence_for_prompt)"'/' \
              -e 's/__format_bad_status__/'"$(color_term_raw -b red none '%s' | wrap_control_sequence_for_prompt)"'/')


# unload my lib modules and set functions for configuratin
unset -f wrap_control_sequence_for_prompt
for l_path in "$DOTFILES_DIR/lib/color_term_raw.sh"; do
  for l_func in $(list_functions_recursively "$l_path"); do
    unset -f "$l_func"
  done
done
unset l_path l_func
unset -f list_functions_recursively


# load local settings
if [ -r "$HOME/usr/local/bashrc" ]; then
  . "$HOME/usr/local/bashrc"
fi
