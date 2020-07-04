# load default settings
[ -r "$HOME/.bashrc.dotold" ] && . "$HOME/.bashrc.dotold"

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

# set prompt
PS1='$(__exit_status=$?; if [ -n "$SSH_TTY" ]; then printf "%s " "\[\033[36m\][SSH]\[\033[0m\]"; fi; printf "%s " "\[\033[34m\]\w\[\033[0m\]"; if [ $__exit_status -eq 0 ]; then printf "%s " "\[\033[1;32m\]\$\[\033[0m\]"; else printf "%s " "\[\033[1;31m\]\$\[\033[0m\]"; fi)'

# load extra modules
[ -r "$HOME/usr/local/bash-completion/etc/profile.d/bash_completion.sh" ] && . "$HOME/usr/local/bash-completion/etc/profile.d/bash_completion.sh"  # bash_completion
[ -r "$HOME/usr/local/git-prompt.sh" ] && {  # git_prompt
  . "$HOME/usr/local/git-prompt.sh"
  PS1='$(__exit_status=$?; if [ -n "$SSH_TTY" ]; then printf "%s " "\[\033[36m\][SSH]\[\033[0m\]"; fi; printf "%s" "$(__git_ps1 "\[\033[35m\](%s)\[\033[0m\] ")"; printf "%s " "\[\033[34m\]\w\[\033[0m\]"; if [ $__exit_status -eq 0 ]; then printf "%s " "\[\033[1;32m\]\$\[\033[0m\]"; else printf "%s " "\[\033[1;31m\]\$\[\033[0m\]"; fi)'
  GIT_PS1_SHOWDIRTYSTATE=1
  GIT_PS1_SHOWSTASHSTATE=1
  GIT_PS1_SHOWUNTRACKEDFILES=1
  GIT_PS1_SHOWUPSTREAM='auto'
  GIT_PS1_STATESEPARATOR=':'
}
[ -r "$HOME/usr/local/init_conda" ] && {  # init_conda
  init_conda() {
    . "$HOME/usr/local/init_conda"
  }
}

# load local settings
[ -r "$HOME/usr/local/bashrc" ] && . "$HOME/usr/local/bashrc"
