# load default settings
if [ -r "$HOME/.bashrc.dotold" ]; then
  . "$HOME/.bashrc.dotold"
fi

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
PS1='$(__exit_status=$?; if [ -n "$SSH_TTY" ]; then printf "%s " "\[\033[1;36m\][SSH]\[\033[0m\]"; fi; printf "%s " "\[\033[1;34m\]\w\[\033[0m\]"; if [ $__exit_status -eq 0 ]; then printf "%s " "\[\033[1;32m\]\$\[\033[0m\]"; else printf "%s " "\[\033[1;31m\]\$\[\033[0m\]"; fi)'

# load extra modules
if [ -r "$HOME/usr/local/bash-completion/etc/profile.d/bash_completion.sh" ]; then
  . "$HOME/usr/local/bash-completion/etc/profile.d/bash_completion.sh"
fi

if [ -r "$HOME/usr/local/git-prompt.sh" ]; then
  . "$HOME/usr/local/git-prompt.sh"
  PS1='$(__exit_status=$?; if [ -n "$SSH_TTY" ]; then printf "%s " "\[\033[1;36m\][SSH]\[\033[0m\]"; fi; printf "%s" "$(__git_ps1 "\[\033[1;35m\](%s)\[\033[0m\] ")"; printf "%s " "\[\033[1;34m\]\w\[\033[0m\]"; if [ $__exit_status -eq 0 ]; then printf "%s " "\[\033[1;32m\]\$\[\033[0m\]"; else printf "%s " "\[\033[1;31m\]\$\[\033[0m\]"; fi)'
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

# load local settings
if [ -r "$HOME/usr/local/bashrc" ]; then
  . "$HOME/usr/local/bashrc"
fi
