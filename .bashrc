# load the default interactive settings
[ -f "$HOME/.bashrc.dotold" ] && . "$HOME/.bashrc.dotold"

# set the environment variables for an interactive session
export PATH="$HOME/bin:$PATH"
export INPUTRC="$HOME/.inputrc"
type vim > /dev/null 2>&1 && export EDITOR="vim"

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

# set the variables about prompts for an interactive session
PS1='$(__exit_status=$?; if [ -n "$SSH_TTY" ]; then printf "\[\033[1;36m\][SSH]\[\033[0m\] "; fi; printf "[\[\033[1;35m\]\u\[\033[0m\]@\[\033[1;33m\]\H\[\033[0m\]:\[\033[1;34m\]\w\[\033[0m\]]\n"; if [ $__exit_status -eq 0 ]; then printf "\[\033[1;32m\]>>\[\033[0m\] "; else printf "\[\033[1;31m\]>>\[\033[0m\] "; fi)'
PS2='\[\033[1;33m\]>>>>\[\033[0m\] '

# load the settings of 'bash-completion'
[ -f "$HOME/usr/bash-completion/etc/profile.d/bash_completion.sh" ] && . "$HOME/usr/bash-completion/etc/profile.d/bash_completion.sh"

# load the local interactive settings
[ -f "$HOME/usr/local/bashrc" ] && . "$HOME/usr/local/bashrc"
