######################################################################
# functions
######################################################################


set_envvar_dotfiles_dir() {
  # Set environment variable DOTFILES_DIR
  # Globals:
  #   None
  # Arguments:
  #   None
  # Outputs:
  #   None
  # Returns:
  #   0
  DOTFILES_DIR="$HOME/.dotfiles"
  export DOTFILES_DIR

  return 0
}


load_default_settings() {
  # Load settings from the default file
  # Globals:
  #   None
  # Arguments:
  #   None
  # Outputs:
  #   None
  # Returns:
  #   0
  if [ -r "$HOME/.bashrc.dotold" ]; then
    . "$HOME/.bashrc.dotold"
  fi

  return 0
}


set_envvars_common() {
  # Set common environment variables
  # Globals:
  #   None
  # Arguments:
  #   None
  # Outputs:
  #   None
  # Returns:
  #   0
  append_item_to_path_envvar() {
    if ! printf '%s' "$PATH" \
           | grep -e "$1" > /dev/null 2>&1; then
      PATH="${1}:$PATH"
    fi
  }

  umask 0022
  append_item_to_path_envvar "$DOTFILES_DIR/bin"
  for l_path in "$HOME/usr/bin" \
                "$HOME/usr/shellshoccar/bin" \
                "$HOME/usr/kotoriotoko/BIN"; do
    if [ -d "$l_path" ]; then
      append_item_to_path_envvar "$l_path"
    fi
  done

  LANG='ja_JP.UTF-8'
  INPUTRC="$HOME/.inputrc"
  EDITOR='vi'
  if ppath vim > /dev/null 2>&1; then
    EDITOR='vim'
  fi
  export PATH LANG INPUTRC EDITOR

  unset l_path
  unset -f append_item_to_path_envvar
  return 0
}


set_aliases() {
  # Set aliases for bash
  # Globals:
  #   None
  # Arguments:
  #   None
  # Outputs:
  #   None
  # Returns:
  #   0
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

  return 0
}


set_bash_prompt() {
  # Set prompt format for bash
  # Globals:
  #   None
  # Arguments:
  #   None
  # Outputs:
  #   None
  # Returns:
  #   0

  # load my original text coloring module
  . "$DOTFILES_DIR/lib/list_functions_recursively.sh"
  . "$DOTFILES_DIR/lib/color_term_raw.sh"

  # function for escape terminal sequence code
  wrap_control_sequence_for_prompt() {
    sed -e 's/\(\\033\)/\\[\1/g' \
        -e 's/\([0-9]m\)/\1\\]/g' \
      | sed -e 's/\\/\\\\/g'
  }

  # set PS1
  PS1=$(printf '%s' '$(__exit_status=$?; printf "__format_user__@__format_host__ " "\u" "\h"; if [ -n "$SSH_CLIENT" ]; then printf "__format_ssh__ " "[SSH]"; fi; if [ -r "$HOME/usr/local/git-prompt.sh" ]; then printf "__format_branch__" "$(__git_ps1 "(%s) ")"; fi; printf "__format_cd__ " "\w"; if [ $__exit_status -eq 0 ]; then printf "__format_good_status__ " "\$"; else printf "__format_bad_status__ " "\$"; fi)' \
          | sed -e 's/__format_user__/'"$(color_term_raw -b magenta none '%s' | wrap_control_sequence_for_prompt)"'/' \
                -e 's/__format_host__/'"$(color_term_raw -b magenta none '%s' | wrap_control_sequence_for_prompt)"'/' \
                -e 's/__format_ssh__/'"$(color_term_raw -b cyan none '%s' | wrap_control_sequence_for_prompt)"'/' \
                -e 's/__format_branch__/'"$(color_term_raw -b yellow none '%s' | wrap_control_sequence_for_prompt)"'/' \
                -e 's/__format_cd__/'"$(color_term_raw -b blue none '%s' | wrap_control_sequence_for_prompt)"'/' \
                -e 's/__format_good_status__/'"$(color_term_raw -b green none '%s' | wrap_control_sequence_for_prompt)"'/' \
                -e 's/__format_bad_status__/'"$(color_term_raw -b red none '%s' | wrap_control_sequence_for_prompt)"'/')

  # unloaded modules and functions recursively
  unset -f wrap_control_sequence_for_prompt
  for l_path in "$DOTFILES_DIR/lib/color_term_raw.sh"; do
    for l_func in $(list_functions_recursively "$l_path"); do
      unset -f "$l_func"
    done
  done
  unset l_path l_func
  unset -f list_functions_recursively

  return 0
}


load_extra_modules() {
  # Load settings for each extra modules
  # Globals:
  #   None
  # Arguments:
  #   None
  # Outputs:
  #   None
  # Returns:
  #   0
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

  return 0
}


load_local_settings() {
  # Load settings from the local file
  # Globals:
  #   None
  # Arguments:
  #   None
  # Outputs:
  #   None
  # Returns:
  #   0
  if [ -r "$HOME/usr/local/bashrc" ]; then
    . "$HOME/usr/local/bashrc"
  fi

  return 0
}


check_is_in_tmux() {
  # Check if it is in a tmux session
  # Globals:
  #   None
  # Arguments:
  #   None
  # Outputs:
  #   None
  # Returns:
  #   in a session, 0
  #   not in a session, 1
  if [ -n "$TMUX" ]; then
    return 0
  else
    return 1
  fi
}


check_is_in_screen() {
  # Check if it is in a GNU screen session
  # Globals:
  #   None
  # Arguments:
  #   None
  # Outputs:
  #   None
  # Returns:
  #   in a session, 0
  #   not in a session, 1
  if [ -n "$STY" ]; then
    return 0
  else
    return 1
  fi
}


choose_and_connect_ssh_host() {
  # Choose and connect a ssh host by prompt
  # Globals:
  #   None
  # Arguments:
  #   None
  # Outputs:
  #   None
  # Returns:
  #   0
  list_ssh_hosts() {
    l_conf_path="$HOME/.ssh/config"

    if [ ! -r "$l_conf_path" ]; then
      return 1
    elif ! grep -e '^Host  *' "$l_conf_path" > /dev/null 2>&1; then
      return 1
    fi
    grep -e '^Host  *' "$l_conf_path" \
      | sed -e 's/^Host  *//'

    unset l_conf_path
    return 0
  }

  if ppath ssh > /dev/null 2>&1 \
       && list_ssh_hosts > /dev/null 2>&1; then
    printf "Connect local or remote?\n" > /dev/tty
    printf "If you connect local, press enter with blank.\n" > /dev/tty
    printf "If you connect remote, press enter with number.\n" > /dev/tty
    printf "\n" > /dev/tty

    l_target_host=$(list_ssh_hosts \
                      | sln)

    if [ ! -z "$l_target_host" ]; then
      exec ssh "$l_target_host"
    fi
    unset l_target_host
  fi

  unset -f list_ssh_hosts
  return 0
}


attach_any_session_on_tmux() {
  # Attach any session on tmux
  # Globals:
  #   None
  # Arguments:
  #   None
  # Outputs:
  #   None
  # Returns:
  #   0
  if ppath tmux > /dev/null 2>&1; then
    if tmux has-session > /dev/null 2>&1; then
      exec tmux attach
    else
      exec tmux new-session
    fi
  fi

  return 0
}


attach_any_session_on_screen() {
  # Attach any session on GNU screen
  # Globals:
  #   None
  # Arguments:
  #   None
  # Outputs:
  #   None
  # Returns:
  #   0
  if ppath screen > /dev/null 2>&1; then
    if screen -list > /dev/null 2>&1; then
      exec screen -r
    else
      exec screen -S my_screen_ses
    fi
  fi

  return 0
}


######################################################################
# main routine
######################################################################


# load settings for each bash sessions
set_envvar_dotfiles_dir
load_default_settings
set_envvars_common
set_aliases
set_bash_prompt
load_extra_modules
load_local_settings


# if it is not in any sessions of terminal-multiplexer,
# 1. choose the host to attach, e.g. local or remote by ssh
# 2. attach any session there, or establish a new session of terminal-multiplexer
if ! check_is_in_tmux && ! check_is_in_screen; then
  choose_and_connect_ssh_host

  attach_any_session_on_tmux
  attach_any_session_on_screen
fi
