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

# define primary prompt
export PS1='[\u@\h \W]\$ '

