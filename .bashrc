# load default settings
[ -f "$HOME/.bashrc.dotold" ] && . "$HOME/.bashrc.dotold"

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

# load extra modules
[ -f "$HOME/usr/local/bash-completion/etc/profile.d/bash_completion.sh" ] && . "$HOME/usr/local/bash-completion/etc/profile.d/bash_completion.sh"  # bash_completion
[ -f "$HOME/usr/local/git-prompt.sh" ] && . "$HOME/usr/local/git-prompt.sh"  # git_prompt
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM='auto'
GIT_PS1_STATESEPARATOR=':'

# set prompts
PS1='$(__exit_status=$?; printf "\[\033[31m\]\u\[\033[0m\] at \[\033[32m\]\H\[\033[0m\] in \[\033[34m\]\w\[\033[0m\] %s\\n" "$(__git_ps1 "on \[\033[33m\](%s)\[\033[0m\]")"; [ -n "$SSH_TTY" ] && printf "\[\033[36m\][SSH]\[\033[0m\] "; [ $__exit_status -eq 0 ] && printf "\[\033[1;32m\]\$\[\033[0m\] " || printf "\[\033[1;31m\]\$\[\033[0m\] ")'

# load local settings
[ -f "$HOME/usr/local/bashrc" ] && . "$HOME/usr/local/bashrc"
