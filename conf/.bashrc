######################################################################
# functions
######################################################################


# load the functions as common settings for bash/zsh
. "$HOME/.shrc_common"


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


set_prompt() {
  # Set prompt format
  # Globals:
  #   None
  # Arguments:
  #   None
  # Outputs:
  #   None
  # Returns:
  #   0

  # load my original text coloring module
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

  # more useful completion for bash
  if [ -r "$HOME/usr/local/bash-completion/etc/profile.d/bash_completion.sh" ]; then
    . "$HOME/usr/local/bash-completion/etc/profile.d/bash_completion.sh"
  fi

  # show information about git branch
  if [ -r "$HOME/usr/local/git-prompt.sh" ]; then
    . "$HOME/usr/local/git-prompt.sh"
    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWSTASHSTATE=1
    GIT_PS1_SHOWUNTRACKEDFILES=1
    GIT_PS1_SHOWUPSTREAM='auto'
    GIT_PS1_STATESEPARATOR=':'
  fi

  # initializer for Anaconda environment
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


######################################################################
# main routine
######################################################################


# load settings for each bash sessions
set_envvar_dotfiles_dir
load_default_settings
set_envvars_common
set_aliases
set_prompt
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
