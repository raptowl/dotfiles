if [ -f "$HOME/.bashrc.dotold" ]; then
	. "$HOME/.bashrc.dotold"
fi

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

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

if [ -f "$HOME/usr/bash-completion/etc/profile.d/bash_completion.sh" ]; then
	. "$HOME/usr/bash-completion/etc/profile.d/bash_completion.sh"
fi

if [ -f "$HOME/.git-completion.bash" ]; then
	. "$HOME/.git-completion.bash"
fi

PS1='$(__exit_status=$?; if [ -n "$SSH_TTY" ]; then printf "\[\033[1;36m\][SSH]\[\033[0m\] "; fi; printf "\[\033[1;34m\]\W\[\033[0m\] "; if [ $__exit_status -eq 0 ]; then printf "\[\033[1;32m\]${__exit_status}>\[\033[0m\] "; else printf "\[\033[1;31m\]${__exit_status}>\[\033[0m\] "; fi)'
PS2='\[\033[1;33m\]>\[\033[0m\] '

if [ -f "$HOME/.bashrc_local" ]; then
	. "$HOME/.bashrc_local"
fi
