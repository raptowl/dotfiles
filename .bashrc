# load $HOME/.bashrc.dotold
if [ -f "$HOME/.bashrc.dotold" ]; then
    . "$HOME/.bashrc.dotold"
fi

# define alias of 'cd'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# define alias of 'ls'
if ls --color > /dev/null 2>&1; then
    alias l='\ls --color=auto'
    alias ll='\ls -l --color=auto'
    alias la='\ls -a --color=auto'
    alias ls='\ls -la --color=auto'
    export LS_COLORS=''
else
    alias l='\ls -G'
    alias ll='\ls -l -G'
    alias la='\ls -a -G'
    alias ls='\ls -la -G'
    export LSCOLORS=''
fi

# load the setting script "bash-completion"
if [ -f "$HOME/usr/bash-completion/etc/profile.d/bash_completion.sh" ]; then
    . "$HOME/usr/bash-completion/etc/profile.d/bash_completion.sh"
fi

# load the setting script "git-completion.bash" for bash
if [ -f "$HOME/.git-completion.bash" ]; then
    . "$HOME/.git-completion.bash"
fi

# define primary prompt
PS1='$(if [ $? -eq 0 ]; then printf "\[\033[32m\]"; else printf "\[\033[31m\]"; fi; if [ $UID -eq 0 ]; then printf "\[\033[1m\]"; fi)\$\[\033[0m\] '

# load $HOME/.bashrc_local
if [ -f "$HOME/.bashrc_local" ]; then
    . "$HOME/.bashrc_local"
fi

