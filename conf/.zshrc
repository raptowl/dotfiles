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
  if [ -r "$HOME/.zshrc.dotold" ]; then
    . "$HOME/.zshrc.dotold"
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

  autoload -Uz promptinit
  promptinit
  prompt adam1

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
  setopt histignorealldups sharehistory

  # Use emacs keybindings even if our EDITOR is set to vi
  bindkey -v

  # Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
  HISTSIZE=1000
  SAVEHIST=10000
  HISTFILE=~/.zsh_history

  # Use modern completion system
  autoload -Uz compinit
  compinit

  zstyle ':completion:*' auto-description 'specify: %d'
  zstyle ':completion:*' completer _expand _complete _correct _approximate
  zstyle ':completion:*' format 'Completing %d'
  zstyle ':completion:*' group-name ''
  zstyle ':completion:*' menu select=2
  eval "$(dircolors -b)"
  zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
  zstyle ':completion:*' list-colors ''
  zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
  zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
  zstyle ':completion:*' menu select=long
  zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
  zstyle ':completion:*' use-compctl false
  zstyle ':completion:*' verbose true

  zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
  zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

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
  if [ -r "$HOME/usr/local/zshrc" ]; then
    . "$HOME/usr/local/zshrc"
  fi

  return 0
}


######################################################################
# main routine
######################################################################


# load settings for each zsh sessions
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
