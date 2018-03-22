# define alias of 'cd'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# define alias of 'ls'
if ls --color > /dev/null 2>&1
then
    alias ls='ls -la --color=auto'
    export LS_COLORS=''
else
    alias ls='ls -la -G'
    export LSCOLORS=''
fi

# define alias of the other
alias grep='grep --color'
alias df='df -h'
alias ps='ps --sort=start_time'

# load the setting file of git-completion for bash
if [ -f "$HOME/.git-completion.bash" ]
then
    . "$HOME/.git-completion.bash"
else
    printf "WARNING: %s/.git-completion.bash not installed.\\n" "$HOME" 1>&2
fi

# define prompt
if [ -f "$HOME/.git-prompt.sh" ]
then
    . "$HOME/.git-prompt.sh"
else
    printf "WARNING: %s/.git-prompt.sh not installed.\\n" "$HOME" 1>&2
fi
export PS1='[\u@\h \W]\$ '

# clock (git branch) [path]
# [user@hostname] $
